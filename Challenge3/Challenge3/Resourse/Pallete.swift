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
    }

    enum Others {
        static let white = Color("customWhite")
    }

    enum Other {
        static let blue = Color("otherBlue")
        static let pink = Color("otherPink")
        static let purple = Color("otherPurple")
        static let peach = Color("otherPeach")
    }

    enum OtherLight {
        static let blue = Color("otherLightBlue")
        static let pink = Color("otherLightPink")
        static let purple = Color("otherLightPurple")
        static let peach = Color("otherLightPeach")
       
    }
    
    enum BlackWhite {
        static let black = Color(.black)
        static let white = Color(.white)
    }
}
