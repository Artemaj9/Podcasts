//
//  AccountSettingsViewModel.swift
//

import Foundation
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

final class AccountSettingsViewModel: ObservableObject {
    @Published var selectedGender: SelectedGender = .male
    @Published var texts: [String] = ["", "", ""]
    @Published var selectedBirthday: Date = .now
    @Published var shouldShowDatePicker: Bool = false
    
    @Published var image: Image?
    @Published var showingImagePicker = false
    @Published var inputImage: UIImage?
    @Published var isButtonsVisible = false
    @Published var showingButtons = false



    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        image = Image(uiImage: inputImage)
    }
}


