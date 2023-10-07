//
//  SplashView.swift
//

import SwiftUI

struct SplashView: View, ItemView {

    // MARK: - Property Wrappers

    @EnvironmentObject var splashViewModel: SplashViewModel

    // MARK: - Internal Properties

    var listener: CustomNavigationContainer?

    // MARK: - Body

    var body: some View {
        Group {
            ProgressView()
        }
        .onAppear {
            DispatchQueue.main.async {
                if !splashViewModel.isNotLoggedIn {
                    listener?.push(view: AuthorizationView())
                } else {
                    listener?.push(view: MainTabBar())
                }
            }
        }
    }
}
