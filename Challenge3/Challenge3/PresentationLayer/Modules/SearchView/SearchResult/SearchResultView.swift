//
//  SearchResultView.swift
//

import SwiftUI

struct SearchResultView: View, ItemView {
    
    // MARK: - Property Wrappers
    
    @ObservedObject var searchViewModel: SearchViewModel
    @State var searchText: String
    @State var categoryTitles = [String]()
    @State var isPopWhenEmpty = true
    
    // MARK: - Internal Properties
    
    var listener: CustomNavigationContainer?
    var categoryName = ""
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            VStack(alignment: .leading) {
                HStack {
                    TextField(
                        "",
                        text: Binding(
                            get: {
                                return searchText
                            },
                            set: { (newValue) in
                                if newValue == "" && isPopWhenEmpty {
                                    listener?.pop()
                                }
                                if newValue.count >= 1 && !isPopWhenEmpty {
                                    isPopWhenEmpty = true
                                }
                                if newValue.count >= 2 {
                                    searchViewModel.getPodcasts(searchText: newValue)
                                }
                                
                                categoryTitles = searchViewModel.podcasts?.compactMap { podcast in
                                    podcast.title
                                } ?? [""]
                                
                                return searchText = newValue
                            }
                        )
                    )
                    .disableAutocorrection(true)
                    .font(.title3)
                    .padding(8)
                    .foregroundColor(Pallete.Other.deepPurpleText)
                    
                    Spacer()
                    
                    Button {
                        listener?.pop()
                    } label: {
                        Image(Images.Icon.closeSquare.rawValue)
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(.trailing)
                    }
                }
                .background(Pallete.BlackWhite.white.cornerRadius(16).opacity(0.7))
                .padding(.horizontal, 20)
                .padding(.bottom, 8)
                
                HStack {
                    Rectangle()
                }
                .padding(.horizontal)
                .foregroundColor(Pallete.Gray.grayDivider)
                .frame(height: 1)
                .padding(.bottom, 4)
                
                Text(Localizable.Search.SarchResult.searchResults)
                    .fontWeight(.semibold)
                    .foregroundColor(Pallete.Other.deepPurpleText)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 8)
                
                ScrollView(showsIndicators: false) {
                    if let podcasts = searchViewModel.podcasts {
                        ForEach(podcasts, id: \.id) { podcast in
                            GeometryReader { geometry in
                                HStack {
                                    CustomImage(
                                        imageString: podcast.image ?? "",
                                        backColor: Pallete.Other.blue,
                                        width: 56, height: 56
                                    )
                                    
                                    CustomLabel(
                                        labelText: podcast.title ?? "",
                                        additionalText: podcast.author ?? "",
                                        labelStyle: .searchResult,
                                        epsText: podcast.ownerName ?? ""
                                    )
                                    
                                    Spacer()
                                }
                                .opacity(getScrollOpacity(geometry: geometry))
                                .padding(.vertical, 4)
                                .onTapGesture {
                                    listener?.push(view: ChannelView(
                                        screenTitle: podcast.title ?? "Unnamed Podcast",
                                        dataForScreen: podcast)
                                    )
                                }
                            }
                            .frame(height: 68)
                        }
                        .padding(.horizontal, 8)
                    }
                    
                    Spacer()
                }
                                
                if let podcastData = categoryName.isEmpty ?
                    searchViewModel.trendingPodcasts : searchViewModel.podcastFromCategory {
                    ForEach(podcastData.indices) { index in
                        GeometryReader { geo in
                            Button {
                                let screenTitle = "Channel"
                                let dataForSendToScreen = podcastData[index]
                                listener?.push(view: ChannelView(
                                    screenTitle: screenTitle, dataForScreen: podcastData[index])
                                )
                            } label: {
                                let bindingData = Binding<CellData>(
                                    get: { return searchViewModel.convertDataToCellData(podcast: podcastData[index]) },
                                    set: {_ in }
                                )
                                FilledWideCell(data: bindingData, isLikeble: false)
                                    .opacity(getScrollOpacity(geometry: geo))
                                    .padding(.vertical, 8)
                            }
                            .frame(height: 88)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
        }
        .onAppear {
            if categoryName.isEmpty {
                searchViewModel.getPodcasts(searchText: searchText)
                searchViewModel.getTrendingPodcasts(max: 100)
            } else {
                searchViewModel.getPodcastsByCategory(categoryName: categoryName)
            }
        }
    }
    
    // MARK: - Functions
    
    func getScrollOpacity(geometry: GeometryProxy) -> Double {
        let maxY = UIScreen.main.bounds.height
        let currentY = geometry.frame(in: .global).minY
        let opacity: Double
        
        let yInitial = 0.9 * maxY
        let yInitial2 = 0.2 * maxY
        let yFinal = maxY
        let yFinal2 = 0.05 * maxY
        
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
