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
    
    private let database = Firestore.firestore()
    private var displayName = ""
    
    // MARK: - Internal functions
    
    func persistImageToStorage(dob: Date, gender: SelectedGender = .male, image: Image?) {
        guard let currentUser = Auth.auth().currentUser else { return }

        guard let imageData = image.asUIImage().jpegData(compressionQuality: 0.2) else { return }

        let storRef = Storage.storage().reference(withPath: currentUser.uid)

        storRef.putData(imageData) { metadata, error in
            if let error {
                print("put data \(error.localizedDescription)")
            }
            
            storRef.downloadURL { (url, error) in
                let userData = [
                    "displayName" : currentUser.displayName ?? "default display name",
                    "uid" : currentUser.uid,
                    "avatarUrl" : url?.absoluteString ?? "",
                    "dob": dob as NSDate,
                    "gender" : gender.rawValue
                ] as [String : Any]

                Firestore.firestore()
                    .collection("users")
                    .document(currentUser.uid)
                    .setData(userData) { error in
                        if let error {
                            print(error)
                        }
                    }

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
        } else if name.contains(" ") {
            return name.components(separatedBy: " ")[0]
        } else {
            return name
        }
    }
    
    func getLastName() -> String {
        let name = getDisplayName()
        if name.contains("@") {
            return name.components(separatedBy: "@")[1]
        } else if name.contains(" ") {
            return name.components(separatedBy: " ")[1]
        } else {
            return ""
        }
    }
    
    func searchImage() {
        let uid = Auth.auth().currentUser?.uid ?? ""
        database.collection("users")
            .document(uid)
            .getDocument { snapshot, error in
                if let error {
                    print(error)
                }

                if let snapshot {
                    self.imageUrl = snapshot["avatarUrl"] as? String ?? ""
                    print("image url: \(self.imageUrl)")
                }
            }
    }
    
    func getEmail() -> String {
        let userEmail = Auth.auth().currentUser?.email ?? ""
        return userEmail
    }
}
