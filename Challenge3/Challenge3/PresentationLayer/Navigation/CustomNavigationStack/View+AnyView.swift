//
//  View+AnyView.swift
//

import SwiftUI

extension View {
    func toAny() -> AnyView { // MARK: func for casting view to any view
        return AnyView(self)
    }
}
