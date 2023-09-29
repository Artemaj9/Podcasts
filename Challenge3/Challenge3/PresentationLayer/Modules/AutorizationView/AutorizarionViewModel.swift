//
//  AutorizarionViewModel.swift
//

import Foundation

final class AuthorizarionViewModel: ObservableObject {
    @Published var login: String = ""
    @Published var password: String = ""
}
