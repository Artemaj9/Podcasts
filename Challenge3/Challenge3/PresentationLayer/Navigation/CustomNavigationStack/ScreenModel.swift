//
//  ScreenModel.swift
//

import SwiftUI

// MARK: just a model for a screen
struct Screen: Identifiable, Equatable {
    static func == (lhs: Screen, rhs: Screen) -> Bool {
        return lhs.id == rhs.id
    }

    public let id: String = UUID.init().uuidString

    public let screen: AnyView
}
