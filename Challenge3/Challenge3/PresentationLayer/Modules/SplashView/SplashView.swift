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
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if !splashViewModel.isNotLoggedIn {
                    listener?.push(view: AuthorizationView())
                } else {
                    listener?.push(view: MainTabBar())
                }
            }
        }
    }
}
