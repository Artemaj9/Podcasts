//
//  FavoritesView.swift
//

import SwiftUI

struct FavoritesView: View, ItemView {
    
    //MARK: - Internal Properties
    
    var listener: CustomNavigationContainer?
    
    //MARK: - Mock data
    
    let data: [(image: String?, firstText: String?, secondText: String?)] = [
        (image: nil, firstText: "Text1", secondText: "Description1"),
        (image: "image2", firstText: "Text2", secondText: "Description2"),
        (image: "image2", firstText: "Text3", secondText: "Description3"),
        (image: "image2", firstText: "Text4", secondText: "Description4")
    ]
    
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
                    
                } label: {
                    Text(Localizable.Favorite.seeAll)
                        .foregroundColor(Pallete.Gray.forText)
                }
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(data, id: \.firstText) { item in
                        FavoritesCell(image: item.image, firstText: item.firstText, secondText: item.secondText)
                    }
                }
                .padding(.horizontal)
            }
            
            Text(Localizable.Favorite.yourPlaylist)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.top, .leading])
            
            CreateButton {
                listener?.push(view: CreatePlaylistView())
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.top, .leading])

            ScrollView() {
                
                ForEach(playlists, id: \.mainTitle) { playlist in
                    BlankWideCell(
                        mainTitle: playlist.mainTitle,
                        secondTitle: playlist.secondTitle
                    )
                    .padding([.top, .leading])
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
    }
}
