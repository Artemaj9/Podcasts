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
    
    // MARK: - Mock data
    
    let playlists: [Playlist] = [
        Playlist(mainTitle: "Tuhan mengapa dia berbeda", secondTitle: "15 Eps"),
        Playlist(mainTitle: "Another Playlist", secondTitle: "10 Eps")
    ]
    
    // MARK: - View's body
    
    var body: some View {
        ScrollView() {
            
            ForEach(playlists, id: \.mainTitle) { playlist in
                BlankWideCell(
                    mainTitle: playlist.mainTitle,
                    secondTitle: playlist.secondTitle
                )
                .padding([.top, .leading])
            }
        }
        .makeCustomNavBar {
            NavigationBars(atView: .favorites) {
                listener?.pop()
            } trailingButtonAction: {

            }
        }
    }
}

struct FavoritesDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesDetailView(screenTitle: "Favorites", dataForScreen: nil)
    }
}
