//
//  Pallete.swift
//

import SwiftUI

enum Pallete {
    enum Blue {
        static let forAccent = Color("blueForAccent")
        static let forOnboarding = Color("blueForOnboarding")
    }

    enum Gray {
        static let forArrow = Color("grayForArrow")
        static let forButton = Color("grayForButton")
        static let forCells = Color("grayForCells")
        static let forNext = Color("grayForNext")
        static let forPhotoCells = Color("grayForPhotoCells")
        static let forTextFields = Color("grayForTextFields")
        static let forText = Color("grayForText")
        static let forDots = Color("grayForDots")
        static let darkerForText = Color("darkGrayForText")
        static let grayDivider = Color("grayDivider")
        static let forChangePic =  Color("grayForChangePicButton")
    }

    enum Others {
        static let white = Color("customWhite")
    }

    enum Other {
        static let blue = Color("otherBlue")
        static let pink = Color("otherPink")
        static let purple = Color("otherPurple")
        static let peach = Color("otherPeach")
        static let green = Color("greenForAuthorization")
        static let deepPurpleText = Color("deepPurpleText")
    }

    enum OtherLight {
        static let blue = Color("otherLightBlue")
        static let pink = Color("otherLightPink")
        static let purple = Color("otherLightPurple")
        static let peach = Color("otherLightPeach")
        static let slightPink = Color("lightPink")
        static let slightGreen = Color("lightGreen")
    }
    
    enum BlackWhite {
        static let black = Color(.black)
        static let white = Color(.white)
    }
}
