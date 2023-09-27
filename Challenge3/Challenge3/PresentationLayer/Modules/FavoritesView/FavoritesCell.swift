//
//  FavoritesCell.swift
//

import SwiftUI

struct FavoritesCell: View {
    let image: String?
    let firstText: String?
    let secondText: String?
    
    var body: some View {
            RoundedRectangle(cornerRadius: 10)
                .fill(Pallete.OtherLight.purple)
                .frame(width: 120, height: 160)
                .overlay(
                    VStack(spacing: 8) {
                        CustomImage(imageString: image, width: 60, height: 60)
                            .padding()
                            .cornerRadius(10)
                            .padding(.top)
                        
                        VStack(spacing: 6) {
                            if let firstText {
                                Text(firstText)
                                    .font(.headline)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Pallete.BlackWhite.black)
                            }
                            
                            if let secondText {
                                Text(secondText)
                                    .font(.subheadline)
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Pallete.Gray.forText)
                            }
                        }
                        .padding(.bottom)
                    }
                )
    }
}

struct FavoritesCell_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesCell(image: nil, firstText: "first", secondText: "second")
    }
}
