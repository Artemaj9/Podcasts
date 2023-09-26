//
//  LoginViewModel.swift
//

import Foundation

final class LoginViewModel: ObservableObject{
    @Published var login = ""
    @Published var password = ""
}
