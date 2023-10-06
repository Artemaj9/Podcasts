//
//  CreatePlaylistView.swift
//

import SwiftUI

struct CreatePlaylistView: View, ItemView {
    
    //MARK: - Property Wrapers
    
    @State private var image: String?
    @State private var title: String = ""
    @State private var isShowBottomSheet = false
    
    //MARK: - Internal Properties
    
    var listener: CustomNavigationContainer?
    
    //MARK: - Mock datas
    
    @State var cellDatas: [CellData] = [
        CellData(id: nil, guid: nil, iconState: true, mainLeft: "Main 1", mainRight: "Right 1", secondLeft: "Second 1", secondRight: "Right Sec 1", image: "image1", iconMode: .select, height: nil),
        CellData(id: nil, guid: nil, iconState: true, mainLeft: "Main 2", mainRight: "Right 2", secondLeft: "Second 2", secondRight: "Right Sec 2", image: "image2", iconMode: .select, height: nil),
        CellData(id: nil, guid: nil, iconState: true, mainLeft: "Main 3", mainRight: "Right 3", secondLeft: "Second 3", secondRight: "Right Sec 3", image: "image3", iconMode: .select, height: nil),
        CellData(id: nil, guid: nil, iconState: true, mainLeft: "Main 4", mainRight: "Right 4", secondLeft: "Second 4", secondRight: "Right Sec 4", image: "image4", iconMode: .select, height: nil)
    ]
    
    var body: some View {
        VStack {
            CustomImage(imageString: image, width: 84, height: 84)
                .onTapGesture {
                    isShowBottomSheet = true
                }
                .padding()
                .cornerRadius(10)
                .padding(.top)
            VStack() {
                TextField("", text: $title)
                    .customPlaceholder(when: title.isEmpty, alinment: .center) {
                        Text(Localizable.Playlist.playlistPlaceholder).foregroundColor(.gray)
                    }
                    .padding(.vertical)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .background(
                        VStack {
                            Spacer()
                            Rectangle()
                                .fill(Pallete.Gray.forText)
                                .frame(height: 1)
                        }
                    )
            }
            .padding([.horizontal, .bottom])
            
          //  SearchBarView(searchText: "", placeholder: "", backgroundColor: Pallete.Gray.forTextFields)
                .frame(height: 32)
            
            ScrollView {
                ForEach($cellDatas) { $data in
                    FilledWideCell(data: $data)
                }
                .padding()
            }
            
            Spacer()
        }
        .overlay {
            BottomSheet(
                isShowing: $isShowBottomSheet,
                content: AnyView(ChangeCoverView(isShowSheet: $isShowBottomSheet))
            )
        }
        .makeCustomNavBar {
            NavigationBars(atView: .createPlaylist) {
                listener?.pop()
            } trailingButtonAction: {
                
            }
        }
    }
}

struct CreatePlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePlaylistView()
    }
}
