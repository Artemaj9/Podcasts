//
//  SplashViewModel.swift
//

import Foundation

class SplashViewModel: ObservableObject {
    @Published var isNotLoggedIn = UserDefaults.standard.bool(forKey: "isNotLoggedIn") {
        didSet {
            UserDefaults.standard.set(isNotLoggedIn, forKey: "isNotLoggedIn")
        }
    }
}
