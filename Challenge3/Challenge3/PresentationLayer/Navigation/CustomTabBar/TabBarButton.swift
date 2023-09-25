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
    let iconName: String

    // MARK: - Body
    var body: some View {
        VStack(alignment: .center) {
            Image(iconName)
                .frame(maxWidth: 25, maxHeight: 25)
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity)
//        .foregroundColor(selectedTab == index ? Colors.main : Colors.black)
        .onTapGesture {
            selectedTab = index
        }
    }
}
