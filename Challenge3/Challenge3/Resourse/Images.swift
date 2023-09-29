//
//  Images.swift
//

import Foundation

enum Images {
    
    enum SystemIcons: String {
        case xmark = "xmark.circle.fill"
    }

    enum Icon: String {
        case arrowLeft, arrowRight, calendar, check, checkFill
        case closeSquare, edit, ellipse, fire, folder
        case heart, heartFill, hide, horizontalIcon, iconGoogle, eye
        case playlist, plus, plusWithBorder, tickSquare
        case profile, shield, unlock
        case appleLogo = "apple.logo"
    }

    enum AudioPlaying: String {
        case next, nextFill, play, playFill, previous, priviousFill, repeatTrack, shuffle
    }

    enum ChangePicture: String {
        case gallery, photo, trash
    }

    enum DefaultView: String {
        case avatar, insertPicture
    }

    enum Onboarding: String, CaseIterable {
        case image1, image2, image3
    }

    enum TabBar: String {
        case bookmark, bookmarkFill, home, homeFill, search, searchFill, setting, settingFill
    }

}
