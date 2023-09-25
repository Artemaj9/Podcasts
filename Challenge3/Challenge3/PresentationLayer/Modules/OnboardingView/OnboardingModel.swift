//
//  OnboardingModel.swift
//

import Foundation

struct OnboardingModel {

    // MARK: - Internal Properties
    static let onboardingImages: [String] = Images.Onboarding.allCases.map { $0.rawValue }
    static let onboardingTitles: [String] = [
        "SUPER APP",
        "SUPER APP\nSUPER APP",
        "SUPER APP\nSUPER APP\nSUPER APP"
    ]
    static let onboardingTexts: [String] = [
        "SUPER APPSUPER APP SUPER APP SUPER APP SUPER APP SUPER APP SUPER APP SUPER APP SUPER APP",
        "SUPER APPSUPER APP SUPER APP SUPER APP SUPER APP SUPER APP SUPER APP SUPER APP SUPER APP",
        "SUPER APPSUPER APP SUPER APP SUPER APP SUPER APP SUPER APP SUPER APP SUPER APP SUPER APP"
    ]
}
