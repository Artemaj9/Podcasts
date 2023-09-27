//
//  PodcastAppApp.swift
//

import SwiftUI

@main
struct Challenge3App: App {

    // MARK: - Property Wrapper
    @StateObject var navigationViewModel = CustomNavigationViewModel()

    @StateObject var favoritesViewModel = FavoritesViewModel()
    @StateObject var homePageViewModel = HomePageViewModel()
    @StateObject var accountSettingsViewModel = AccountSettingsViewModel()
    @StateObject var profileViewModel = ProfileSettingsViewModel()
    @StateObject var channelViewModel = ChannelViewModel()
    @StateObject var nowPlayingViewModel = NowPlayingViewModel()
    @StateObject var searchViewModel = SearchViewModel()
    @StateObject var searchResultViewModel = SearchResultViewModel()
    @StateObject var createPlaylistViewModel = CreatePlaylistViewModel()
    @StateObject var createWithEmailViewModel = CreateWithEmailViewModel()
    @StateObject var authorizarionViewModel = AuthorizarionViewModel()

    // MARK: - Body
    var body: some Scene {
        WindowGroup { // добавить if какой экран будет показываться при старте
            NavigationContainer(viewModel: navigationViewModel) {
               FavoritesView()
            }
            .environmentObject(favoritesViewModel)
            .environmentObject(homePageViewModel)
            .environmentObject(accountSettingsViewModel)
            .environmentObject(profileViewModel)
            .environmentObject(channelViewModel)
            .environmentObject(nowPlayingViewModel)
            .environmentObject(searchViewModel)
            .environmentObject(searchResultViewModel)
            .environmentObject(createPlaylistViewModel)
            .environmentObject(createWithEmailViewModel)
            .environmentObject(authorizarionViewModel)
        }
    }
}
