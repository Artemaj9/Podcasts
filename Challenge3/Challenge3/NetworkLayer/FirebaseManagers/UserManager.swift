//
//  UserManager.swift
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth
import UIKit

@MainActor class UserManager: ObservableObject {
    
    @Published var imageUrl: URL?
    
    //MARK: - Private properties
    
    private let db = Firestore.firestore()
    private var displayName = ""
    
    //MARK: - Internal functions
    
    //Download user image
    func saveUserData(image: Image?, dob: Date, gender: SelectedGender = .male) {
        let uiImage: UIImage = image.asUIImage()
        
        guard let imageData = uiImage.jpegData(compressionQuality: 0.2) else { return }
        
        let storageRef = Storage.storage().reference().child("images")
        
        storageRef.putData(imageData, metadata: nil) { (metadata, error) in
            if let error = error {
                print("Ошибка загрузки изображения в Firebase Storage: \(error.localizedDescription)")
            }
            
            storageRef.downloadURL { (url, error) in
                if let error = error {
                    print("Ошибка получения URL изображения: \(error.localizedDescription)")
                }
                
                if let imageUrl = url {
                    print("URL загруженного изображения: \(imageUrl)")
                    self.storeUserInformation(imageProfileURL: imageUrl, dob: dob, gender: gender)
                }
            }
        }
    }
    
    //Send date of birth, gender, image
    func storeUserInformation(imageProfileURL: URL, dob: Date, gender: SelectedGender = .male) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userData = ["uid" : uid, "avatarUrl" : imageProfileURL.absoluteString, "dob": dob as NSDate, "gender": gender.rawValue] as [String : Any]
        
        Firestore.firestore()
            .collection("users")
            .document(uid)
            .setData(userData) { error in
                if let error {
                    print(error)
                }
            }
    }
    
    //Get a fullname
    func getDisplayName() -> String {
        let name = Auth.auth().currentUser?.displayName ?? "llll"
        displayName = name
        return name
    }
    
    //Get first name
    func getFirstName() -> String {
        let name = getDisplayName()
        if name.contains("@"){
            return name.components(separatedBy: "@")[0]
        } else {
            return name.components(separatedBy: " ")[0]
        }
    }
    
    //Get last name
    func getLastName() -> String {
        let name = getDisplayName()
        if name.contains("@") {
            return name.components(separatedBy: "@")[1]
        } else {
            return name.components(separatedBy: " ")[1]
        }
        
    }
    //Get image url adress
    func getImageUrl() {
        self.imageUrl = URL(string: searchImage())
    }
    
    //Seacrh image by uid
    func searchImage() -> String {
        let auth = Auth.auth().currentUser?.uid
        var output = ""
        db.collection("users").document(auth ?? "").getDocument { snapshot, error in
            
            if let error {
                print(error)
            }
            
            if let snapshot {
                dump(snapshot["avatarUrl"] ?? "")
                
                self.imageUrl = URL(string: snapshot["avatarUrl"] as? String ?? "")
            }
        }
        return output
    }
    
    func getEmail() -> String {
        let auth = (Auth.auth().currentUser?.email)!
        return auth
    }
    
}

//MARK: - Extensions

extension View {
    public func asUIImage() -> UIImage {
        let controller = UIHostingController(rootView: self)
        
        controller.view.backgroundColor = .clear
        
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)
        
        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()
        
        
        let image = controller.view.asUIImage()
        controller.view.removeFromSuperview()
        return image
    }
}

extension UIView {
    public func asUIImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
