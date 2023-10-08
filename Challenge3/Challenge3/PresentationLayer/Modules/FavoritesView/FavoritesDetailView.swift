//
//  FavoritesDetailView.swift
//

import SwiftUI
import PodcastIndexKit

struct FavoritesDetailView: View, ItemView {
    
    // MARK: - Property wrapper
    
    @ObservedObject var viewModel = FavoritesViewModel()
    
    // MARK: - Internal Properties
    
    let screenTitle: String
    let dataForScreen: [Podcast]?
    
    var listener: CustomNavigationContainer?
    
    var podcastData: [Podcast]? {
        if dataForScreen == nil {
            viewModel.getPodcastsFromCategory(category: screenTitle)
            return viewModel.podcasts
        } else {
            return dataForScreen
        }
    }
    
    // MARK: - View's body
    
    var body: some View {
        ZStack {
            BackgroundView()
            
            ScrollView() {
                if let podcasts = podcastData {
                    ForEach(podcasts, id: \.id) { podcast in
                        Button {
                            // TODO: replace string with localizable string
                            let screenTitle = "Channel"
                            let dataForSendToScreen = podcast
                            listener?.push(view: ChannelView(
                                screenTitle: screenTitle,
                                dataForScreen: dataForSendToScreen))
                        } label: {
                            BlankWideCell(
                                mainTitle: podcast.title,
                                secondTitle: podcast.author,
                                image: podcast.image
                            )
                            .padding([.top, .leading])
                        }
                    }
                } else {
                    // TODO: add skeleton
                }
            }
        }
        .makeCustomNavBar(showBackground: false) {
            NavigationBars(atView: .favorites, screenTitle: screenTitle) {
                listener?.pop()
            }
        }
    }
}

struct FavoritesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesDetailView(screenTitle: "Favorites", dataForScreen: nil)
    }
}
