//
//  DropDownList.swift
//

import SwiftUI

struct DropDownList: View {

    // MARK: - Property Wrappers

    @Binding var searchText: String
    @Binding var dropDownList: [String]
    @Binding var showDropDown: Bool
    @Binding var transitionFlag: Bool

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(showsIndicators: true) {
                ForEach(dropDownList, id: \.self) { dropText in
                    VStack(alignment: .leading) {
                        Text("\(dropText)")
                            .padding(.horizontal)
                            .font(.body)
                            .foregroundColor(Pallete.Other.deepPurpleText)

                        Divider()
                    }
                    .onTapGesture {
                        searchText = "\(dropText)"
                        showDropDown.toggle()
                        transitionFlag.toggle()
                    }
                }
            }
        }
        .background(Pallete.BlackWhite.white.opacity(0.9))
        .opacity(showDropDown ? 1 : 0)
        .opacity(searchText.isEmpty ? 0 : 1)
        .animation(.easeIn, value: showDropDown)
        .animation(.easeIn, value: searchText.isEmpty)
        .onAppear {
            showDropDown = false
        }
    }
}
