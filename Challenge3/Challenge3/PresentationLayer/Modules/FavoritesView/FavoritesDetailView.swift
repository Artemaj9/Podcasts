//
//  FavoritesDetailView.swift
//

import SwiftUI
import PodcastIndexKit

struct FavoritesDetailView: View, ItemView {
    
    // MARK: - Internal Properties
    
    let screenTitle: String
    let dataForScreen: [Podcast]?
    
    var listener: CustomNavigationContainer?
    
    // MARK: - View's body
    
    var body: some View {
        ScrollView {
            
            if let dataForScreen {
                ForEach(dataForScreen, id: \.id) { podcast in
                    BlankWideCell(
                        mainTitle: podcast.title,
                        secondTitle: podcast.author,
                        image: podcast.image
                    )
                    .padding([.top, .leading])
                    .onTapGesture {
                        listener?.push(view: ChannelView(screenTitle: podcast.title ?? "", dataForScreen: podcast))
                    }
                }
            }
        }
        .makeCustomNavBar {
            NavigationBars(atView: .favorites) {
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
