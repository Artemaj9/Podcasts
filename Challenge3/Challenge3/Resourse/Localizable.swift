//
//  Strings.swift
//

import SwiftUI
import Foundation

struct Localizable {

    enum Autorization {
        static var enterLogin = NSLocalizedString("Autorization.enterLogin", comment: "")
        static var login = NSLocalizedString("Autorization.login", comment: "")
        static var enterPassword = NSLocalizedString("Autorization.enterPassword", comment: "")
        static var password = NSLocalizedString("Autorization.password", comment: "")
        static var logIn = NSLocalizedString("Autorization.logIn", comment: "")
        static var continueWith = NSLocalizedString("Autorization.orContinueWith", comment: "")
        static var signInWithGoogle = NSLocalizedString("Autorization.signInWithGoogle", comment: "")
        static var signInWithApple = NSLocalizedString("Autorization.signInWithApple", comment: "")
        static var dontHaveAccount = NSLocalizedString("Autorization.dontHaveAccount", comment: "")
        static var signIn = NSLocalizedString("Autorization.signIn", comment: "")
    }

    enum CreateAccount {
        enum StartCreate {
            static let navTitle = localizedStringKey("StartCreate.navTitle")
        }
        enum CreateWithEmail {}
    }

    enum Onboarding {
        static var skip = localizedStringKey("Onboarding.skip")
        static var next = localizedStringKey("Onboarding.next")
        static var getStarted = localizedStringKey("Onboarding.getStarted")
    }

    enum HomePage {}

    enum Channel {}

    enum NowPlaying {}

    enum Search {
        enum SearchBasic {}
        enum SarchResult {}
    }

    enum Favorite {}

    enum Playlist {}

    enum ProfileSettings {}

    enum AccountSettings {}

}

private func localizedStringKey(_ key: String) -> LocalizedStringKey {
    LocalizedStringKey(key)
}
