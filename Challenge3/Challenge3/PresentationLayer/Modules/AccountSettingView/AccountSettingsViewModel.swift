//
//  AccountSettingsViewModel.swift
//

import Foundation

final class AccountSettingsViewModel: ObservableObject {
    @Published var selectedGender: SelectedGender = .male
    @Published var texts: [String] = ["", "", ""]
    @Published var selectedBirthday: Date = .now
    @Published var shouldShowDatePicker: Bool = false
}
