//
//  CreatePlaylistView.swift
//

import SwiftUI

struct CreatePlaylistView: View, ItemView {
    @State private var image: String?
    @State var iconState: Bool = false
    
    var listener: CustomNavigationContainer?

    var body: some View {
        VStack {
            CustomImage(imageString: image, width: 84, height: 84)
                .padding()
                .cornerRadius(10)
                .padding(.top)
            
            VStack {
                Text("Give a name for your playlist")
                Rectangle()
                    .fill(Color.black)
                    .frame(width: .infinity, height: 1)
            }
            .padding(.horizontal)
            
            SearchBarView(searchText: "", placeholder: "")
                .background(Pallete.Gray.forCells)
            
            ScrollView() {
                ForEach(0..<3) { _ in
                    NavigationLink(destination: Icons()) {
                        FilledWideCell(
                            iconState: Binding<Bool?>(
                                get: { iconState },
                                set: { newValue in iconState = newValue ?? false }
                            ),
                            mainLeft: "Ngobam", mainRight: "Gofar Hilman",
                            secondLeft: "Music & Fun", secondRight: "23 Eps",
                            iconMode: .select
                        )
                        .padding([.top, .horizontal])
                    }
                }
            }
        }
    }
}

struct CreatePlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePlaylistView()
    }
}

