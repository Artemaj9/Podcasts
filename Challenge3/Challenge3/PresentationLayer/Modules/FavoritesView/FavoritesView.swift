//
//  FavoritesView.swift
//

import SwiftUI
import PodcastIndexKit

struct FavoritesView: View, ItemView {

    @EnvironmentObject var favoritesViewModel: FavoritesViewModel

    //MARK: - Internal Properties

    var listener: CustomNavigationContainer?
    
    let playlists: [Playlist] = [
        Playlist(mainTitle: "Tuhan mengapa dia berbeda", secondTitle: "15 Eps"),
        Playlist(mainTitle: "Another Playlist", secondTitle: "10 Eps")
    ]
    
    //MARK: - View's Body
    
    var body: some View {
        VStack {
            
            HStack {
                Text(Localizable.Favorite.favorites)
                
                Spacer ()
                
                Button {
                    listener?.push(view: FavoritesDetailView(screenTitle: "Favorites", dataForScreen: nil))
                } label: {
                    Text(Localizable.Favorite.seeAll)
                        .foregroundColor(Pallete.Gray.forText)
                }
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(favoritesViewModel.favoriteNetworkPodcasts, id: \.id) { podcast in
                        FavoritesCell(
                            image: podcast.image,
                            firstText: podcast.title,
                            secondText: podcast.author
                        )
                    }
                }
                .padding(.horizontal)
            }
            
            HStack() {
                Text(Localizable.Favorite.yourPlaylist)
                Spacer()
            }
            .padding([.top, .leading])
            
            
            HStack {
                CreateButton {
                    listener?.push(view: CreatePlaylistView())
                }
                Spacer()
            }
            .padding([.top, .leading])
            
            ScrollView() {
                
                ForEach(playlists, id: \.mainTitle) { playlist in
                    BlankWideCell(
                        mainTitle: playlist.mainTitle,
                        secondTitle: playlist.secondTitle
                    )
                    .padding([.top, .leading])
                    .onTapGesture {
                        // TODO: add localizable string
                        listener?.push(view: ChannelView(screenTitle: "Channel", dataForScreen: nil))
                    }
                }
            }
        }
        .makeCustomNavBar {
            NavigationBars(atView: .playlist) { }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(FavoritesViewModel())
    }
}
