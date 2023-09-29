//
//  UserModel.swift
//

import Firebase

struct User: Identifiable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let profileImageUrl: String
    
    init(data: [String: Any]) {
        self.id = data["uid"] as? String ?? ""
        self.firstName = data["firstName"] as? String ?? ""
        self.lastName = data["lastName"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.profileImageUrl = data["profileImageUrl"] as? String ?? ""
    }
}

