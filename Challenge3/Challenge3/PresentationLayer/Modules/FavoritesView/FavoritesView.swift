//
//  FavoritesView.swift
//

import SwiftUI
import PodcastIndexKit

struct FavoritesView: View, ItemView {

    @EnvironmentObject var favoritesViewModel: FavoritesViewModel

    //MARK: - Internal Properties

    var listener: CustomNavigationContainer?
    
    //MARK: - View's Body
    
    var body: some View {
        FavoritesDetailView(dataForScreen: favoritesViewModel.favoriteNetworkPodcasts, listener: listener)
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(FavoritesViewModel())
    }
}
