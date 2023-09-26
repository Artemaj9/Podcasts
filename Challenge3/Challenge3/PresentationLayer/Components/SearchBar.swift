//
//  SearchBar.swift
//

import SwiftUI

struct SearchBarView: View {

    @State var searchText: String
    let placeholder: String

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
                .foregroundColor(Color.black)
                .disableAutocorrection(true)
                .overlay(
                    ZStack {
                        Image(Images.TabBar.search.rawValue)
                            .padding()
                            .offset(x: 0)
                            .opacity(searchText.isEmpty ? 0.8 : 1)
                            .scaleEffect(1.4)
                            .saturation(searchText.isEmpty ? 0.1 : 1)
                            .animation(.easeIn, value: searchText.isEmpty)
                    }
                    ,alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white))
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Pallete.Blue.forOnboarding.ignoresSafeArea()
            SearchBarView(searchText: "", placeholder: "Podcast, chanell, or artist...")
                .previewLayout(.sizeThatFits)
        }
    }
}
