//
//  UserManager.swift
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class UserManager: ObservableObject {
    
    @Published var imageUrl: String?
    
    // MARK: - Private properties
    
    private var selectedImageUrl: URL?
    private let database = Firestore.firestore()
    private var displayName = ""
    
    // MARK: - Internal functions
    
    func persistImageToStorage(image: Image?) {
        let uiImage: UIImage = image.asUIImage()
        if image == nil {
            self.selectedImageUrl = nil
        }
        
        guard let imageData = uiImage.jpegData(compressionQuality: 0.2) else { return }
        
        let storageRef = Storage.storage().reference().child("images")
        
        storageRef.putData(imageData) { (metadata, error) in
            
            storageRef.downloadURL { (url, error) in
                if let url {
                    self.selectedImageUrl = url
                }
            }
            
        }
    }
    
    func storeUserInformation(dob: Date, gender: SelectedGender = .male) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let userData = [
            "uid" : uid,
            "avatarUrl" : String(selectedImageUrl?.absoluteString ?? ""),
            "dob": dob as NSDate,
            "gender": gender.rawValue
        ] as [String : Any]
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .setData(userData) { error in
                if let error {
                    print(error)
                }
            }
    }
    
    func getDisplayName() -> String {
        let name = Auth.auth().currentUser?.displayName ?? "Unknown"
        displayName = name
        return name
    }
    
    func getFirstName() -> String {
        let name = getDisplayName()
        if name.contains("@") {
            return name.components(separatedBy: "@")[0]
        } else {
            return name.components(separatedBy: " ")[0]
        }
    }
    
    func getLastName() -> String {
        let name = getDisplayName()
        if name.contains("@") {
            return name.components(separatedBy: "@")[1]
        } else {
            return name.components(separatedBy: " ")[1]
        }
    }
    
    func searchImage() {
        let uid = Auth.auth().currentUser?.uid ?? ""
        database.collection("users").document(uid).getDocument { snapshot, error in
            if let error {
                print(error)
            }
            if let snapshot {
                self.imageUrl =  String(snapshot["avatarUrl"] as? String ?? "")
            }
        }
    }
    
    func getEmail() -> String {
        let userEmail = Auth.auth().currentUser?.email ?? ""
        return userEmail
    }
}
