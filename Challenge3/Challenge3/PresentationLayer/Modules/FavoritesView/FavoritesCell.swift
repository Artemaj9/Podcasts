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
            .fill(Pallete.OtherLight.peach)
            .frame(width: 120, height: 160)
            .overlay(
                VStack(spacing: 10) {
                    if let image {
                        Image(image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .cornerRadius(10)
                            .padding(.top, 30)
                    } else {
                        Text("")
                            .frame(width: 60, height: 60)
                            .cornerRadius(10)
                            .background(Pallete.Gray.forPhotoCells)
                            .padding(.top, 30)
                    }
                    
                    Spacer()
                    
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
                    .padding(.bottom, 20)
                }
            )
    }
}

struct FavoritesCell_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesCell(image: nil, firstText: "first", secondText: "second")
    }
}
