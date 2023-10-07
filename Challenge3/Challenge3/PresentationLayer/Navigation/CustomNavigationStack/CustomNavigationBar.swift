//
//  CustomNavigationBar.swift
//

import SwiftUI

struct CustomNavBar<Content: View>: View {

    // MARK: - Internal Properties
    var showBackground: Bool
    var content: () -> Content

    // MARK: - Body
    var body: some View {
        self.content()
            .padding(.bottom, 10)
            .background {
                if showBackground {
                    Color.white
                        .ignoresSafeArea()
                        .opacity(0.97)
                        .blur(radius: 5, opaque: true)
                }
            }
    }
}

extension View {
    func makeCustomNavBar<Content: View>(showBackground: Bool = true, content: @escaping () -> Content) -> some View {
        VStack {
            self.safeAreaInset(edge: .top) {
                CustomNavBar(showBackground: showBackground) {
                    VStack {
                        content()
                    }
                }
            }
            Spacer()
        }
    }
}
