//
//  SearchResultView.swift
//

import SwiftUI

struct SearchResultView: View, ItemView {
    
    // MARK: - Property Wrappers
    @StateObject var vm = SearchResultViewModel()
    
    // MARK: - Internal Properties
    var listener: CustomNavigationContainer?

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
               
            Text("Search Results")
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
                    Text("All Podcast")
                        .fontWeight(.light)
                        .foregroundColor(Pallete.Other.deepPurpleText)
                    Spacer()
                }
                ForEach(0..<20) { index in
                    GeometryReader { geo in
                        FilledWideCell(mainLeft: "Between love and career", secondLeft: "56:38", secondRight: "56 Eps", image: "", iconMode: .blank)
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
