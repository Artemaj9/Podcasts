//
//  SearchResultView.swift
//

import SwiftUI

struct SearchResultView: View, ItemView {
    
    // MARK: - Property Wrappers
    
    @StateObject var vm = SearchResultViewModel()
    
    // MARK: - Internal Properties
    
    var listener: CustomNavigationContainer?
    
    //MARK: - Mock datas
    
    @State var cellDatas: [CellData] = [
        CellData(id: nil, guid: nil, iconState: true, mainLeft: "Main 1", mainRight: "Right 1", secondLeft: "Second 1", secondRight: "Right Sec 1", image: "image1", iconMode: .blank, height: nil),
        CellData(id: nil, guid: nil, iconState: true, mainLeft: "Main 2", mainRight: "Right 2", secondLeft: "Second 2", secondRight: "Right Sec 2", image: "image2", iconMode: .like, height: nil),
        CellData(id: nil, guid: nil, iconState: true, mainLeft: "Main 3", mainRight: "Right 3", secondLeft: "Second 3", secondRight: "Right Sec 3", image: "image3", iconMode: .select, height: nil),
        CellData(id: nil, guid: nil, iconState: true, mainLeft: "Main 4", mainRight: "Right 4", secondLeft: "Second 4", secondRight: "Right Sec 4", image: "image4", iconMode: .blank, height: nil)
    ]

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Baby Pesut")
                    .fontWeight(.light)
                    .foregroundColor(Pallete.Other.deepPurpleText)
                Spacer()
                Button {
                    listener?.pop()
                } label: {
                    Image(Images.Icon.closeSquare.rawValue)
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.trailing)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 8)
            HStack {
                Rectangle()
            }
            .padding(.horizontal)
            .foregroundColor(Pallete.Gray.grayDivider)
            .frame(height: 1)
            .padding(.bottom, 4)
               
            Text(Localizable.Search.SarchResult.searchResults)
                .fontWeight(.semibold)
                .foregroundColor(Pallete.Other.deepPurpleText)
            
                .padding(.horizontal, 20)
                .padding(.vertical, 8)
            ScrollView(showsIndicators: false) {
                ForEach(0..<5) { index in
                    GeometryReader { geometry in
                        HStack() {
                            CustomImage(imageString: "", backColor: Pallete.Other.blue, width: 56, height: 56)
                            CustomLabel(labelText: "Baby Pesut Podcast", additionalText: "Dr. Oi om jean", labelStyle: .searchResult, epsText: "56 EPS")
                            Spacer()
                        }
                        .opacity(vm.getScrollOpacity(geometry: geometry))
                        .padding(.vertical, 4)
                    }
                    .frame(height: 68)
                   
                    }
            .padding(.horizontal, 8)
                HStack {
                    Text(Localizable.Search.SarchResult.allEpisodes)
                        .fontWeight(.light)
                        .foregroundColor(Pallete.Other.deepPurpleText)
                    Spacer()
                }
                ForEach(0..<20) { index in
                    GeometryReader { geo in
                        ForEach($cellDatas) { $data in
                            FilledWideCell(data: $data)
                        }
                            .opacity(vm.getScrollOpacity(geometry: geo))
                            .padding(.vertical, 8)
                            
                    }
                    .frame(height: 88)
               }
            }
            .padding(.horizontal, 20)
        }
    }
}

struct SearchResultView_Previews: PreviewProvider {
    static var previews: some View {
        SearchResultView()
    }
}
