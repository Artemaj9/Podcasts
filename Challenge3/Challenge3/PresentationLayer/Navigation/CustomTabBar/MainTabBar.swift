//
//  MainTabBar.swift
//

import SwiftUI
import Kingfisher

struct MainTabBar: View, ItemView {
    var listener: CustomNavigationContainer?
    
    @State private var selectedTab = 0
    
    @ObservedObject var player = PlayerViewModel.shared
    @ObservedObject var authModel = AuthenticationViewModel.shared
    // под каждую вкладку таббара создается свой навигейшн стек
    @StateObject var firstTabNavigationModel = CustomNavigationViewModel()
    @StateObject var secondTabNavigationModel = CustomNavigationViewModel()
    @StateObject var thirdTabNavigationModel = CustomNavigationViewModel()
    @StateObject var fourthTabNavigationModel = CustomNavigationViewModel()
    
    @EnvironmentObject var homeViewModel: HomePageViewModel
    @EnvironmentObject var searchViewModel: SearchViewModel
    @EnvironmentObject var favoritesViewModel: FavoritesViewModel
    @EnvironmentObject var profileViewModel: ProfileSettingsViewModel
    
    var body: some View {
        VStack {
            // Your main content
            switch selectedTab {
            case 0:
                NavigationContainer(viewModel: firstTabNavigationModel) {
                    HomePageView(listener: firstTabNavigationModel as? CustomNavigationContainer)
                }
            case 1:
                NavigationContainer(viewModel: secondTabNavigationModel) {
                    SearchView(listener: secondTabNavigationModel as? CustomNavigationContainer)
                }
            case 2:
                NavigationContainer(viewModel: thirdTabNavigationModel) {
                    FavoritesView(listener: thirdTabNavigationModel as? CustomNavigationContainer)
                }
            case 3:
                NavigationContainer(viewModel: fourthTabNavigationModel) {
                    ProfilesettingsView(listener: fourthTabNavigationModel as? CustomNavigationContainer)
                }
            default:
                EmptyView()
            }
        }
        .safeAreaInset(edge: .bottom) {
            if authModel.authenticationState != .authenticated {
                
            } else if firstTabNavigationModel.isRootView && secondTabNavigationModel.isRootView {
                VStack {
                    if player.isPlaying {
                        Button {
                            listener?.push(view: NowPlayingView())
                        } label: {
                            let title = player.episodeTitle
                            
                            ZStack(alignment: .leading) {
                                VStack(spacing: 0) {
                                    ZStack(alignment: .leading) {
                                        RoundedRectangle(cornerRadius: 1)
                                            .foregroundColor(.gray)
                                        
                                        RoundedRectangle(cornerRadius: 1)
                                            .foregroundColor(Pallete.Blue.forAccent)
                                            .frame(width: 0.5 * player.displayTime)
                                            .animation(.easeIn, value: player.displayTime)
                                    }
                                    .frame(height: 3)
                                    .padding(.top, 4)
                                    .padding(.horizontal, 10)
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(height: 66)
                                        .foregroundColor(Pallete.Blue.forOnboarding)
                                }
                                
                                HStack(spacing: 10) {
                                    if !player.getImageUrl().isEmpty {
                                        KFImage(URL(string: player.getImageUrl()))
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(Circle())
                                            .padding(13)
                                    } else {
                                        Circle()
                                            .foregroundColor(Pallete.Other.peach)
                                            .padding(13)
                                    }
                                    
//                                    Spacer()
                                    
                                    Text(title)
                                        .fontWeight(.thin)
                                        .lineLimit(2)
//                                        .truncationMode(.tail)
                                        .minimumScaleFactor(0.8)
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                    
                                    HStack(spacing: 14) {
                                        Button {
                                            player.play_prev()
                                        } label: {
                                            Image(Images.AudioPlaying.previous.rawValue)
                                        }
                                        Button {
                                            player.isPlaying ?
                                            player.pause() :
                                            player.play()
                                        } label: {
                                            Image(Images.AudioPlaying.play.rawValue)
                                        }
                                        Button {
                                            player.play_next()
                                        } label: {
                                            Image(Images.AudioPlaying.next.rawValue)
                                        }
                                    }
                                    .padding(.trailing, 8)
                                }
                            }
                            .frame(height: 66)
                            .padding(.horizontal, 24)
                        }
                    }
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: 68)
                        .background(.white)
                        .cornerRadius(20)
                        .shadow(
                            color: Color(red: 0.21, green: 0.22, blue: 0.3).opacity(0.08),
                            radius: 24
                        )
                        .padding(.horizontal, 24)
                        .overlay {
                            HStack {
                                Spacer()
                                TabBarButton(
                                    selectedTab: $selectedTab,
                                    index: 0,
                                    activeIconName: Images.TabBar.homeFill.rawValue,
                                    inactiveIconName: Images.TabBar.home.rawValue
                                )
                                TabBarButton(
                                    selectedTab: $selectedTab,
                                    index: 1,
                                    activeIconName: Images.TabBar.searchFill.rawValue,
                                    inactiveIconName: Images.TabBar.search.rawValue
                                )
                                TabBarButton(
                                    selectedTab: $selectedTab,
                                    index: 2,
                                    activeIconName: Images.TabBar.bookmarkFill.rawValue,
                                    inactiveIconName: Images.TabBar.bookmark.rawValue
                                )
                                TabBarButton(
                                    selectedTab: $selectedTab,
                                    index: 3,
                                    activeIconName: Images.TabBar.settingFill.rawValue,
                                    inactiveIconName: Images.TabBar.setting.rawValue
                                )
                                Spacer()
                            }
                            .padding(.horizontal, 31)
                        }
                }
            }
        }
    }
}

struct MainTabBar_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBar()
            .environmentObject(SearchViewModel())
            .environmentObject(HomePageViewModel())
            .environmentObject(SearchViewModel())
            .environmentObject(FavoritesViewModel())
            .environmentObject(ProfileSettingsViewModel())
    }
}

