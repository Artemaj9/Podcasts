//
//  TabBarButton.swift
//

import SwiftUI

import SwiftUI

struct TabBarButton: View {
    let index: Int
    let iconName: Image
    @Binding var selectedTab: Int
    @Environment(\.locale) var locale: Locale

    var body: some View {
        VStack(alignment: .center) {
            iconName
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
