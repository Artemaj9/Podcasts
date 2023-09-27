//
//  Strings.swift
//

import SwiftUI
import Foundation

struct Localizable {

    enum Autorization {}

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

    enum AccountSettings {
        static let gender = localizedStringKey("AccountSettingsView.gender")
        static let dateOfBirth = localizedStringKey("AccountSettingsView.gender")
        static let saveChanges = NSLocalizedString("AccountSettingsView.saveChanges", comment: "")
    }

}

private func localizedStringKey(_ key: String) -> LocalizedStringKey {
    LocalizedStringKey(key)
}
