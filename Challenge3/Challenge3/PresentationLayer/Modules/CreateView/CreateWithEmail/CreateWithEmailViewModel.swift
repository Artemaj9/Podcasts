//
//  CreateWithEmailViewModel.swift
//

import Foundation

final class CreateWithEmailViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confpassword = ""
}
