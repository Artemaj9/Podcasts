//
//  AccountSettingsViewModel.swift
//

import AVFoundation
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI
import FirebaseAuth

final class AccountSettingsViewModel: ObservableObject {
    @ObservedObject var authViewModel = AuthenticationViewModel.shared
    
    @Published var selectedGender: SelectedGender = .male
    @Published var texts: [String] = ["", "", ""]
    @Published var changePassword = ""
    @Published var confirmChangePassword = ""
    @Published var selectedBirthday: Date = .now
    @Published var shouldShowDatePicker: Bool = false
    
    @Published var image: Image?
    @Published var warningMessage = ""
    @Published var isWarningPresented = false
    @Published var isShowingImagePicker = false
    @Published var isChoosingCameraMode = false
    
    //MARK: - Private properties
    
    private (set) var cameraMode: UIImagePickerController.SourceType = .photoLibrary
    
    //MARK: - Internal functions
    
    func saveUserData() {
        changeDisplayName()
        changeUserEmail()
    }
    
    func presentCamera() {
        cameraMode = .camera
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            DispatchQueue.main.async {
                self.isShowingImagePicker = true
            }
            
        case .denied, .restricted:
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.warningMessage = "Warning"
                self.isShowingImagePicker = false
                self.isWarningPresented = true
            }
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if granted {
                    DispatchQueue.main.async {
                        self?.isShowingImagePicker = true
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.showCameraWarning()
                    }
                }
            }
            
        @unknown default:
            assertionFailure("Unhandled AVCaptureDevice authorization status")
        }
    }
    
    func presentLibraryPicker() {
        cameraMode = .photoLibrary
        isShowingImagePicker = true
    }
    
    func openSettings() {
        if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(settingsUrl, options: [:])
        }
    }
    
    //MARK: - Private functions
    
    private func changeUserEmail() {
        if !texts[2].isEmpty{
            authViewModel.email = texts[2]
            authViewModel.changeUserEmail()
        }
    }
    
    
    private func changeDisplayName() {
        if !texts[0].isEmpty, !texts[1].isEmpty {
            authViewModel.firstName = texts[0]
            authViewModel.lastName = texts[1]
            authViewModel.changeDisplayName()
        }
    }
    
    
    private func showCameraWarning() {
        warningMessage = "error"
        isWarningPresented = true
    }
}
