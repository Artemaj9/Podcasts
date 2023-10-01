//
//  Font.swift
//

import SwiftUI

enum CustomFontWeight: String {
    case regular = "Regular"
    case semibold = "SemiBold"
    case bold = "Bold"
}

enum CustomFontStyle: String {
    case plusJakartaSans = "PlusJakartaSans"
    case sfPro = "SF Pro"
    case manrope = "Manrope"
}

func getCustomFont(style: CustomFontStyle, size: Double, weight: CustomFontWeight = .regular) -> Font {
    let customFontName = "\(style.rawValue)-\(weight.rawValue)"
    return .custom(customFontName, size: size)
}
