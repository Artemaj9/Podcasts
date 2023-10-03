//
//  AccountSettingsViewModel.swift
//

import AVFoundation
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI


final class AccountSettingsViewModel: ObservableObject {
    @Published var selectedGender: SelectedGender = .male
    @Published var texts: [String] = ["", "", ""]
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

        func saveImage(_ image: Image?) {
            // to do firebase
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

        private func showCameraWarning() {
            warningMessage = "eror"
            isWarningPresented = true
        }
    }

