//
//  Strings.swift
//

import SwiftUI
import Foundation

struct Localizable {

    enum Autorization {}

    enum CreateAccount {
        enum StartCreate {
            static let navTitle = NSLocalizedString("StartCreate.navTitle", comment: "")
            static let greeting = NSLocalizedString("StartCreate.greeting", comment: "")
            static let login = NSLocalizedString("StartCreate.login", comment: "")
            static let already = NSLocalizedString("StartCreate.alreadyHave", comment: "")
            static let contWithEmail = NSLocalizedString("StartCreate.contWithEmail", comment: "")
            static let contWithGoogle = NSLocalizedString("StartCreate.continueWithGoogle", comment: "")
            static let orContWith = NSLocalizedString("StartCreate.orContinueWith", comment: "")
            static let enterEmail = NSLocalizedString("StartCreate.enterEmail", comment: "")
            static let email = NSLocalizedString("StartCreate.email", comment: "")
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
