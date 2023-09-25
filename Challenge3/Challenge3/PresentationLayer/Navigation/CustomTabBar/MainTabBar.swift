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
                NavigationContainer(viewModel: secondTabNavigationModel) {
                    FavoritesView(listener: secondTabNavigationModel as? CustomNavigationContainer)
                }
            case 3:
                NavigationContainer(viewModel: secondTabNavigationModel) {
                    ProfilesettingsView(listener: secondTabNavigationModel as? CustomNavigationContainer)
                }
            default:
                EmptyView()
            }

            // Custom Tab Bar доделать замену картинок на таб баре
            if firstTabNavigationModel.isRootView && secondTabNavigationModel.isRootView {
                HStack {
                    Spacer()
                    TabBarButton(selectedTab: $selectedTab, index: 0,
                                 iconName: Images.TabBar.home.rawValue)
                    //                    Spacer()
                    TabBarButton(selectedTab: $selectedTab, index: 1,
                                 iconName: Images.TabBar.setting.rawValue)
                    TabBarButton(selectedTab: $selectedTab, index: 2,
                                 iconName: Images.TabBar.bookmark.rawValue)
                    TabBarButton(selectedTab: $selectedTab, index: 3,
                                 iconName: Images.TabBar.setting.rawValue)
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
