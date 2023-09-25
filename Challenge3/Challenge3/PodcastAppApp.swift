//
//  PodcastAppApp.swift
//

import SwiftUI

@main
struct Challenge3App: App {
    //добавить все вью модели приложения
    
    @StateObject var navigationViewModel = CustomNavigationViewModel()
    @StateObject var homeViewModel = HomePageViewModel()
    @StateObject var searchViewModel = SearchViewModel()
    @StateObject var favoritesViewModel = FavoritesViewModel()
    @StateObject var profileViewModel = ProfileSettingsViewModel()
    
    var body: some Scene {
        WindowGroup { //добавить if какой экран будет показываться при старте
            NavigationContainer(viewModel: navigationViewModel) {
               OnboardingView()
            }
            
            //добавить все вьюмодели
            .environmentObject(homeViewModel)
            .environmentObject(searchViewModel)
            .environmentObject(favoritesViewModel)
            .environmentObject(profileViewModel)
            .environmentObject(navigationViewModel)
        }
    }
}
