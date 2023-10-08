//
//  SplashView.swift
//

import SwiftUI

struct SplashView: View, ItemView {

    // MARK: - Property Wrappers

    @ObservedObject var authModel = AuthenticationViewModel.shared
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
                if authModel.authenticationState != .authenticated {
                    listener?.push(view: AuthorizationView())
                } else {
                    listener?.push(view: MainTabBar())
                }
            }
        }
    }
}
