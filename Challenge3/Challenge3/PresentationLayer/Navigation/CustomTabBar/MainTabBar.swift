//
//  MainTabBar.swift
//

import SwiftUI

struct MainTabBar: View, ItemView {
    var listener: CustomNavigationContainer?

    @State private var selectedTab = 0

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

            if firstTabNavigationModel.isRootView && secondTabNavigationModel.isRootView {
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
                        activeIconName: Images.TabBar.settingFill.rawValue,
                        inactiveIconName: Images.TabBar.setting.rawValue
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
                .frame(height: 50)
                .background(Pallete.Gray.forNext)
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
