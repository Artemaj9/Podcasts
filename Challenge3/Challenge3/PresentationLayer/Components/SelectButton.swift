//
//  SelectButton.swift
//

import SwiftUI

struct SelectButton: View {
    
    // MARK: - Internal Properties
    var image: String = Images.ChangePicture.photo.rawValue
    var text: String
    
    // MARK: - Body
    var body: some View {
        HStack{
            Image(image)
                .aspectRatio(contentMode: .fit)
                .padding()
            
            Text(text)
                .font(.system(size: 14).bold())
            
            Spacer()
        }
        .background {
            Rectangle()
                .foregroundColor(Pallete.Gray.forChangePic)
                .cornerRadius(8)
            
        }
    }
}


