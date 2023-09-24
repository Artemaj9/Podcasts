//
//  Strings.swift
//

import SwiftUI

struct Localizable {
    
    enum Autorization {}
    
    enum CreateAccount {
        enum StartCreate {
            static let navTitle = localizedStringKey("StartCreate.navTitle")
        }
        enum CreateWithEmail {}
    }
    
    enum Onboarding {}
    
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
