//
//  Ext+Placeholder.swift
//

import SwiftUI

extension View {
    func customPlaceholder<Content: View>(
        when shouldShow: Bool,
        alinment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alinment) {
            placeholder()
                .opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
