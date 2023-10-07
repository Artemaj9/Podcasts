//
//  SearchBar.swift
//

import SwiftUI

struct SearchBarView: View {

    // MARK: - Property Wrappers

    @Binding var searchText: String
    @FocusState var isFocused: Bool
    
    // MARK: - Internal Properties
    
    let placeholder: String
    let backgroundColor: Color
    var searchFunc: () -> Void

    var body: some View {
        HStack {
            Image(systemName: Images.SystemIcons.xmark.rawValue)
                .foregroundColor(
                    searchText.isEmpty ?
                    Color.gray.opacity(0) : Pallete.Blue.forAccent.opacity(1)
                )
                .opacity(searchText.isEmpty ? 0.0 : 0.8)
                .animation(.easeIn, value: searchText.isEmpty)
                .onTapGesture {
                    UIApplication.shared.endEditing()
                    searchText = ""
                }
            
            TextField(placeholder, text: $searchText)
                .focused($isFocused)
                .foregroundColor(Pallete.BlackWhite.black)
                .disableAutocorrection(true)
                .overlay(
                    ZStack {
                        Image(Images.TabBar.search.rawValue)
                            .padding()
                            .offset(x: 0)
                            .opacity(searchText.isEmpty ? 0.8 : 1)
                            .scaleEffect(1.4)
                            .saturation(searchText.isEmpty ? 0.1 : 1)
                            .colorMultiply(searchText.isEmpty ?  Pallete.Other.pink : Pallete.Other.deepPurpleText)
                            .animation(.easeIn, value: searchText.isEmpty)
                    }
                    ,alignment: .trailing
                )
                .submitLabel(.search)
                .onSubmit {
                    if !searchText.isEmpty {
                        searchFunc()
                    }
                }
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(backgroundColor)
        .shadow(radius: isFocused ? 2 : 0)
        .animation(.linear, value: isFocused))
        .padding()
    }
}
