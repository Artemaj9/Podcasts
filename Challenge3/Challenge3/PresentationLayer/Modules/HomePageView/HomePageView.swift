//
//  HomePageView.swift
//

import SwiftUI
import Kingfisher

struct HomePageView: View, ItemView {
    
    // MARK: - Property Wrapper
    
    @EnvironmentObject var viewModel: HomePageViewModel
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    
    // MARK: - Internal Properties
    
    var listener: CustomNavigationContainer?
    
    var strings = Localizable.HomePage.self

    // MARK: - Body

    var body: some View {
        VStack {
            Button {
                
            } label: {
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
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16) {
                    HStack {
                        Text(strings.rndEpisodes)
                            .font(.system(size: 16, weight: .semibold))
                        
                        Spacer()
                        
                        Button {
                            let dataForSendToScreen = viewModel.newPodcasts
                            let screenTitle = strings.rndEpisodes
                            listener?.push(view: FavoritesDetailView(screenTitle: screenTitle, dataForScreen: dataForSendToScreen))
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
                                            // TODO: add localizable string
                                            let screenTitle = "Channel"
                                            let dataForSendToScreen = item
                                            listener?.push(view: ChannelView(
                                                screenTitle: screenTitle,
                                                dataForScreen: dataForSendToScreen)
                                            )
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
                                        let screenTitle = "Channel"
                                        let dataForSendToScreen = viewModel.podcastFromCategory![index]
                                        listener?.push(view: ChannelView(
                                            screenTitle: screenTitle,
                                            dataForScreen: dataForSendToScreen)
                                        )

                                    } label: {
                                        let nonBindingData = viewModel.convertDataToCellData(podcast: viewModel.podcastFromCategory![index])
                                        let bindingData = Binding<CellData>(
                                            get: { return viewModel.convertDataToCellData(podcast: viewModel.podcastFromCategory![index]) },
                                            set: {
                                                if $0.iconState {
                                                    viewModel.addFavorite(podcastId: $0.id ?? 0)
                                                } else {
                                                    viewModel.removeFavorite(podcastId: $0.id ?? 0)
                                                }
                                                viewModel.fetchFavoriteData()
                                                favoritesViewModel.searchFavoritePodcastsFromIndexKit()
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
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
            .environmentObject(HomePageViewModel())
            .environmentObject(FavoritesViewModel())
    }
}
