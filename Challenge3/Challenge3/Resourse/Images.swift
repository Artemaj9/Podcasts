//
//  Images.swift
//

import Foundation

enum Images {

    enum Icon: String {
        case arrowLeft, calendar, check, checkFill
        case closeSquare, edit, ellipse, fire, folder
        case heart, heartFill, hide, horizontalIcon, iconGoogle
        case playlist, plus, plusWithBorder, tickSquare
    }

    enum AudioPlaying: String {
        case next, nextFill, play, playFill, previous, previousFill, repeatTrack, shuffle
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
