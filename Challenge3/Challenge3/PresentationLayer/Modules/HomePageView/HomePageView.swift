//
//  HomePageView.swift
//

import SwiftUI
import Kingfisher

struct HomePageView: View, ItemView {
    
    // MARK: - Internal Properties
    
    var listener: CustomNavigationContainer?
    
    // MARK: - Property Wrapper
    
    @ObservedObject var viewModel = HomePageViewModel()
    
    // MARK: - Internal Properties
    
    var strings = Localizable.HomePage.self
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16) {
                HStack {
                    Text(strings.rndEpisodes)
                        .font(.system(size: 16, weight: .semibold))
                    
                    Spacer()
                    
                    Button {
                        // TODO: - Add Navigation to detail fav view
                        let dataForSendToScreen = viewModel.newPodcasts
                        listener?.push(view: FavoritesDetailView())
                    } label: {
                        Text(strings.seeAll)
                            .foregroundColor(Pallete.Gray.forText)
                            .font(.system(size: 16))
                    }
                    
                }
                .padding(.horizontal, 32)
                .padding(.top)
                
                VStack(spacing: 24) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            Rectangle()
                                .fill(.clear)
                                .frame(width: 24, height: 0)
                            
                            if let newPodcasts = viewModel.newPodcasts {
                                ForEach(newPodcasts, id: \.id) { item in
                                    Button {
                                        let dataForSendToScreen = item
                                        // TODO: add navigation to channel view
                                        listener?.push(view: ChannelView())
                                    } label: {
                                        ZStack {
                                            if let podImage = item.image {
                                                KFImage(URL(string: podImage))
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 144, height: 200)
                                                    .clipShape(RoundedRectangle(cornerRadius: 12))
                                            }
                                            
                                            VStack {
                                                Spacer()
                                                
                                                RoundedRectangle(cornerRadius: 12)
                                                    .fill(Pallete.BlackWhite.white.opacity(0.6))
                                                    .frame(width: 144, height: 64)
                                                    .overlay() {
                                                        VStack(alignment: .leading) {
                                                            Spacer()
                                                            CustomLabel(
                                                                labelText: item.title ?? "",
                                                                additionalText: "",
                                                                epsText: ""
                                                            )
                                                        }
                                                    }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    HStack {
                        if !viewModel.categories.isEmpty {
                            CategoryTabView(
                                selectedCategory: $viewModel.selectedCategory,
                                data: viewModel.categories)
                        } else {
                            // TODO: add skeleton
                        }
                    }
                }
                
                ScrollView {
                    LazyVStack() {
                        if let podcastData = viewModel.podcastFromCategory {
                            ForEach(podcastData.indices) { index in
                                Button {
                                    let dataForSendToScreen = viewModel.podcastFromCategory![index]
                                    // TODO: add function for going to detail page
                                    listener?.push(view: ChannelView())
                                } label: {
                                    let bindingData = Binding<CellData>(
                                        get: { return viewModel.podcastFromCategory![index] },
                                        set: { newValue in
                                            viewModel.podcastFromCategory?[index] = newValue
                                        }
                                    )
                                    FilledWideCell(data: bindingData)
                                }
                            }
                        } else {
                            // TODO: add skeleton
                        }
                    }
                    .padding(.horizontal, 32)
                }
            }
        }
        .makeCustomNavBar {
            HStack {
                CustomLabel(labelText: "Abigael Amaniah", additionalText: "Love,life and chill", labelStyle: .homepage, epsText: "")
                Spacer()
                CustomImage(
                    imageString: "",
                    width: 48, height: 48
                )
                .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 4)
            }
            .padding(.horizontal, 32)
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}
