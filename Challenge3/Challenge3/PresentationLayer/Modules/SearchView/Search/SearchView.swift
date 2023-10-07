//
//  SearchView.swift
//

import SwiftUI
import PodcastIndexKit

struct SearchView: View, ItemView {

    // MARK: - Property Wrappers
    
    @StateObject var searchViewModel = SearchViewModel()
    @State var showDropDown = false
    @State var searchText: String = ""
    @State var transitionFlag = false
    
    // MARK: - Internal Properties
    
    var listener: CustomNavigationContainer?
    let aspectRatio = 0.57
    let padding: CGFloat = 16
    let columns: [GridItem] = [
        GridItem(.flexible(), spacing: -8, alignment: nil),
        GridItem(.flexible(), spacing: -8, alignment: nil)
    ]
    let buttonColor = [
        Pallete.OtherLight.blue, Pallete.Other.blue, Pallete.OtherLight.purple,
        Pallete.OtherLight.peach, Pallete.Other.peach, Pallete.OtherLight.pink,
        Pallete.OtherLight.slightGreen, Pallete.Other.green
    ]
    
    // MARK: - Body
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                BackgroundSearchView()
                
                VStack(spacing: 4) {
                    Text(Localizable.Search.SearchBasic.search)
                        .fontWeight(.semibold)
                        .padding(.vertical, 20)
                    
                    ZStack(alignment: .trailing) {
                        SearchBarView(
                            searchText: Binding(
                                get: {
                                    return searchText
                                },
                                set: { (newValue) in
                                    if newValue.count >= 1 {
                                        searchViewModel.getPodcasts(searchText: newValue)
                                    } else {
                                        showDropDown = false
                                    }
                                    
                                    searchViewModel.podcastTitles = searchViewModel.podcasts?.compactMap{ podcast in
                                        podcast.title
                                    } ?? [""]
                                    
                                    showDropDown = searchViewModel.podcastTitles.first != ""
                                    return searchText = newValue
                                }),
                            placeholder: Localizable.Search.SearchBasic.chanOrArtist,
                            backgroundColor: Pallete.BlackWhite.white
                        ) {
                            listener?.push(
                                view: SearchResultView(
                                    searchViewModel:searchViewModel,
                                    searchText: $searchText)
                            )
                        }
                        .onChange(of: searchText) { newValue in
                            if transitionFlag {
                                transitionFlag.toggle()
                                listener?.push(
                                    view: SearchResultView(
                                        searchViewModel:searchViewModel,
                                        searchText: $searchText)
                                )
                            }
                        }
                        
                        Circle()
                            .fill()
                            .opacity(0.0001)
                            .frame(width: 70, height: 70)
                            .offset(x: -20)
                            .onTapGesture {
                                if searchText.count > 1 {
                                    listener?.push(
                                        view: SearchResultView(
                                            searchViewModel:searchViewModel,
                                            searchText: $searchText)
                                    )
                                }
                            }
                    }

                    HStack {
                        Text(Localizable.Search.SearchBasic.topGen)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Button {
                            listener?.push(view: FavoritesDetailView(
                                screenTitle: Localizable.Search.SearchBasic.topGen,
                                dataForScreen: searchViewModel.trendingPodcasts)
                            )
                        } label: {
                            Text(Localizable.Search.SearchBasic.seeAll)
                                .foregroundColor(Pallete.Gray.forText)
                        }
                    }
                    .offset(y: 16)
                    .padding(.horizontal, 28)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            if let trending = searchViewModel.trendingPodcasts {
                                let displayedPodcasts = trending.filter {
                                    $0.title != nil  && $0.title!.count < 10 }
                                ForEach(Array(displayedPodcasts.indices), id: \.self) { index in
                                        GenresButton(
                                            title: displayedPodcasts[index].title!,
                                            backgroundColor: buttonColor[index % buttonColor.count],
                                            hSize: geometry.size.width * 0.4
                                        ) {
                                            listener?.push(view: ChannelView(
                                                screenTitle: displayedPodcasts[index].title!,
                                                dataForScreen: displayedPodcasts[index])
                                            )
                                        }
                                    }
                            }
                        }
                        .padding(.vertical)
                        .padding(.horizontal, 24)
                    }
                    
                    Spacer()

                    HStack {
                        Text(Localizable.Search.SearchBasic.browesAll)
                            .fontWeight(.semibold)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 28)

                    VStack {
                        ScrollView(showsIndicators: false) {
                            LazyVGrid(
                                columns: columns,
                                alignment: .center,
                                spacing: 0
                            ) {
                                ForEach(Array(searchViewModel.categories.indices), id: \.self) { index in
                                    GeometryReader { geo2 in
                                        GenresButton(
                                            title: searchViewModel.categories[index],
                                            backgroundColor: buttonColor[index % buttonColor.count],
                                            hSize: geometry.size.width * 0.4) {
                                                searchText = ""
                                                listener?.push(view: SearchResultView(
                                                    searchViewModel: searchViewModel,
                                                    searchText: $searchText,
                                                    categoryName: searchViewModel.categories[index])
                                                )
                                            }
                                            .opacity(getScrollOpacity(geometry: geo2))
                                    }
                                    .frame(
                                        width: geometry.size.width * 0.4,
                                        height: geometry.size.width * 0.4 * aspectRatio + padding,
                                        alignment: .center
                                    )
                                }
                            }
                        }
                        .padding(.horizontal, 12)
                    }
                    .padding(.leading, -2)
                    .padding(.trailing, 10)
                }

                DropDownList(
                    searchText: $searchText,
                    dropDownList: $searchViewModel.podcastTitles,
                    showDropDown: $showDropDown,
                    transitionFlag: $transitionFlag
                )
                .padding(20)
                .offset(y: 120)
                .frame(height: 230)
            }
        }
        .task {
            searchViewModel.getCategories()
            searchViewModel.getTrendingPodcasts(max: 10)
        }
    }

    // MARK: - Functions

    func getScrollOpacity(geometry: GeometryProxy) -> Double {
        let maxY = UIScreen.main.bounds.height
        let currentY = geometry.frame(in: .global).minY
        let opacity: Double
        
        let yInitial = 0.9 * maxY
        let yInitial2 = 0.48 * maxY
        let yFinal = maxY
        let yFinal2 = 0.44 * maxY
        
        let k = 1 / (yInitial - yFinal)
        let kTop = 1 / (yInitial2 - yFinal2)
        let b = -k * yFinal
        let bTop = -kTop * yFinal2
        
        if currentY < yInitial && currentY > yInitial2 {
            opacity = 1
        } else if currentY >= yInitial {
            opacity = k * currentY + b
        } else {
            opacity = kTop * currentY + bTop
        }
        return opacity
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
