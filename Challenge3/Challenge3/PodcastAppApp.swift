//
//  PodcastAppApp.swift
//

import SwiftUI
import FirebaseCore
import PodcastIndexKit
import AVFoundation

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        PodcastIndexKit.setup(apiKey: APIRequest.apiKey,
                              apiSecret: APIRequest.apiSecret,
                              userAgent: APIRequest.userAgent)
        return true
    }
}

@main
struct Challenge3App: App {
    
    // MARK: - Property Wrappers
    
    @StateObject var navigationViewModel = CustomNavigationViewModel()
    
    @StateObject var splashViewModel = SplashViewModel()
    @StateObject var favoritesViewModel = FavoritesViewModel()
    @StateObject var homePageViewModel = HomePageViewModel()
    @StateObject var accountSettingsViewModel = AccountSettingsViewModel()
    @StateObject var profileViewModel = ProfileSettingsViewModel()
    @StateObject var channelViewModel = ChannelViewModel()
    @StateObject var nowPlayingViewModel = NowPlayingViewModel()
    @StateObject var searchViewModel = SearchViewModel()
    @StateObject var createPlaylistViewModel = CreatePlaylistViewModel()
    @StateObject var createWithEmailViewModel = CreateWithEmailViewModel()
    @StateObject var authorizarionViewModel = AuthorizarionViewModel()
    @StateObject var searchManager = SearchManager()
    @StateObject var userManager = UserManager()
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    // MARK: - Body
    var body: some Scene {
        WindowGroup { // добавить if какой экран будет показываться при старте
            NavigationContainer(viewModel: navigationViewModel) {
                SplashView()
            }
            .environmentObject(splashViewModel)
            .environmentObject(favoritesViewModel)
            .environmentObject(homePageViewModel)
            .environmentObject(accountSettingsViewModel)
            .environmentObject(profileViewModel)
            .environmentObject(channelViewModel)
            .environmentObject(nowPlayingViewModel)
            .environmentObject(searchViewModel)
            .environmentObject(createPlaylistViewModel)
            .environmentObject(createWithEmailViewModel)
            .environmentObject(authorizarionViewModel)
            .environment(\.managedObjectContext, FavoritesDataManager.shared.container.viewContext)
            .environmentObject(searchManager)
            .environmentObject(userManager)
        }
    }
}
