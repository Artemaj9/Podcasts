//
//  CustomNavigationBar.swift
//

import SwiftUI

struct CustomNavBar<Content: View>: View {

    // MARK: - Internal Properties
    var content: () -> Content

    // MARK: - Body
    var body: some View {
        self.content()
            .padding(.bottom, 10)
            .background {
                Color.white
                    .ignoresSafeArea()
                    .opacity(0.97)
                    .blur(radius: 5, opaque: true)
            }
    }
}

extension View {
    func makeCustomNavBar<Content: View>(content: @escaping () -> Content) -> some View {
        VStack {
            self.safeAreaInset(edge: .top) {
                CustomNavBar {
                    VStack {
                        content()
                    }
                }
            }
            Spacer()
        }
    }
}
