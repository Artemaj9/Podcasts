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
        enum CreateWithEmail {
            static var firstName = NSLocalizedString("CreateWithEmail.firstName", comment: "")
            static var lastName = NSLocalizedString("CreateWithEmail.lastName", comment: "")
            static var email = NSLocalizedString("CreateWithEmail", comment: "")
            static var password = NSLocalizedString("CreateWithEmail.password", comment: "")
            static var confPassword = NSLocalizedString("CreateWithEmail.confPassword", comment: "")
            static var firstNameField = NSLocalizedString("CreateWithEmail.firstNameField", comment: "")
            static var lastNameField = NSLocalizedString("CreateWithEmail.lastNameField", comment: "")
            static var emailField = NSLocalizedString("CreateWithEmail.emailField", comment: "")
            static var passwordFiled = NSLocalizedString("CreateWithEmail.passwordField", comment: "")
            static var confPasswordFiled = NSLocalizedString("CreateWithEmail.confPasswordField", comment: "")
            static var complete = NSLocalizedString("CreateWithEmail.complete", comment: "")
            static var signUpAdit = NSLocalizedString("CreateWithEmail.signUpAdit", comment: "")
            static var alreadyHave = NSLocalizedString("CreateWithEmail.alreadyHave", comment: "")
            static var login = NSLocalizedString("CreateWithEmail.login", comment: "")
            static var signUp = NSLocalizedString("CreateWithEmail.signUp", comment: "")
        }
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
        enum SarchResult {
            static var searchResults = NSLocalizedString("SearchResults.searchResults", comment: "")
            static var allEpisodes = NSLocalizedString("SearchResults.allEpisodes", comment: "")
        }
    }

    enum Favorite {
        static var favorites = localizedStringKey("Favorites.favorites")
        static var seeAll = localizedStringKey("Favorites.seeAll")
        static var createPlaylist = localizedStringKey( "Favorites.createPlaylist")
        static var yourPlaylist = localizedStringKey("Favorites.yourPlaylist")
    }

    enum Playlist {}

    enum ProfileSettings {
        static var accountSetting = NSLocalizedString("ProfileSetting.accountSetting", comment: "")
        static var changePassword = NSLocalizedString("ProfileSetting.changePassword", comment: "")
        static var forgetPassword = NSLocalizedString("ProfileSetting.forgetPassword", comment: "")
        static var logOut = NSLocalizedString("ProfileSetting.logOut", comment: "")
    }

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
