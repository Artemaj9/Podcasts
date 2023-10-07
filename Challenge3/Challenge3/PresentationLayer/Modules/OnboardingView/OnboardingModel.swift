//
//  OnboardingModel.swift
//

import Foundation

struct OnboardingModel {

    // MARK: - Internal Properties
    static let onboardingImages: [String] = Images.Onboarding.allCases.map { $0.rawValue }
    static let onboardingTitles: [String] = [
        Localizable.Onboarding.podcastApp,
        Localizable.Onboarding.favoriteAndYour,
        Localizable.Onboarding.theAbilityToCreate
    ]
    static let onboardingTexts: [String] = [
        Localizable.Onboarding.findYourFavorite,
        Localizable.Onboarding.youCanChoose,
        Localizable.Onboarding.youCanSetUp
    ]
}
