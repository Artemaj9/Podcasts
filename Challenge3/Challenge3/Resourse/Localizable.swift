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

    enum Favorite {
        static var favorites = localizedStringKey("Favorites.favorites")
        static var seeAll = localizedStringKey("Favorites.seeAll")
        static var createPlaylist = localizedStringKey( "Favorites.createPlaylist")
        static var yourPlaylist = localizedStringKey("Favorites.yourPlaylist")
    }

    enum Playlist {}

    enum ProfileSettings {}

    enum AccountSettings {
        static var gender = localizedStringKey("AccountSettingsView.gender")
        static var dateOfBirth = localizedStringKey("AccountSettingsView.gender")
        static var saveChanges = NSLocalizedString("AccountSettingsView.saveChanges", comment: "")
        static var male = NSLocalizedString("AccountSettingsView.male", comment: "")
        static var female = NSLocalizedString("AccountSettingsView.female", comment: "")
        static var firstName = NSLocalizedString("AccountSettingsView.firstName", comment: "")
        static var lastName = NSLocalizedString("AccountSettingsView.lastName", comment: "")
        static var email = NSLocalizedString("AccountSettingsView.email", comment: "")
    }

}

private func localizedStringKey(_ key: String) -> LocalizedStringKey {
    LocalizedStringKey(key)
}
