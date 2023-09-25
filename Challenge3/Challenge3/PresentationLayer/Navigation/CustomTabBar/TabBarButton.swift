//
//  TabBarButton.swift
//

import SwiftUI

struct TabBarButton: View {

    // MARK: - Property Wrapper
    @Binding var selectedTab: Int
    @Environment(\.locale) var locale: Locale

    // MARK: - Internal Properties
    let index: Int
    let activeIconName: String
    let inactiveIconName: String

    // MARK: - Body
    var body: some View {
        VStack(alignment: .center) {
            Image(selectedTab == index ? activeIconName : inactiveIconName)
                .frame(maxWidth: 25, maxHeight: 25)
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity)
        .onTapGesture {
            withAnimation {
                selectedTab = index
            }
        }
    }
}
