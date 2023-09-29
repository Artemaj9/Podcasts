//
//  ChangeCover.swift
//

import SwiftUI

struct ChangeCoverView: View, ItemView {
    @Binding var isShowSheet: Bool
    
    
    var listener: CustomNavigationContainer?
    
    //MARK: - Mock data
    
    var data = ["image1", "image2", "image3"]
    
    var body: some View {
        VStack(spacing: 30) {
            VStack(spacing: 15) {
                HStack {
                    Text(Localizable.Playlist.chooseImage)
                    Spacer()
                    Button {
                        
                    } label: {
                        Text(Localizable.Playlist.seeAll)
                            .foregroundColor(Pallete.Gray.forText)
                    }
                } .padding(.top)
                
                ScrollView(.horizontal) {
                    HStack(spacing: 16) {
                        ForEach(data, id: \.self) { data in
                            CustomImage(imageString: data, width: 100, height: 100)
                                .background(Pallete.OtherLight.peach)
                                .cornerRadius(15)
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            CustomButton(title: Localizable.Playlist.select,
                         buttonType:.select) {}
        }
        
        .makeCustomNavBar {
            NavigationBars(atView: .chageCover) {
                listener?.pop()
                isShowSheet = false
            }
        }
    }
}

struct ChangeCoverView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeCoverView(isShowSheet: .constant(false))
    }
}
