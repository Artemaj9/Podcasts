//
//  Strings.swift
//

import SwiftUI
import Foundation

struct Localizable {

    enum Autorization {
        static var firstName = NSLocalizedString("Authorizaion.firstName", comment: "")
        static var lastName = NSLocalizedString("Authorizaion.lastName", comment: "")
        static var email = NSLocalizedString("Authorizaion.email", comment: "")
        static var password = NSLocalizedString("Authorizaion.password", comment: "")
        static var confPassword = NSLocalizedString("Authorizaion.confPassword", comment: "")
        static var firstNameField = NSLocalizedString("Authorizaion.firstNameField", comment: "")
        static var lastNameField = NSLocalizedString("Authorizaion.lastNameField", comment: "")
        static var emailField = NSLocalizedString("Authorizaion.emailField", comment: "")
        static var passwordFiled = NSLocalizedString("Authorizaion.passwordField", comment: "")
        static var confPasswordFiled = NSLocalizedString("Authorizaion.confPasswordField", comment: "")
        static var signUp = NSLocalizedString("Authorizaion.signUp", comment: "")
        static var signUpAdit = NSLocalizedString("Authorizaion.signUpAdit", comment: "")
        static var alreadyHave = NSLocalizedString("Authorizaion.alreadyHave", comment: "")
        static var login = NSLocalizedString("Authorizaion.login", comment: "")
    }

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

    enum Channel {
        static var allEpisode = localizedStringKey("Channel.allEpisode")
    }

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
