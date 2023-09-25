//
//  Label.swift
//


import SwiftUI

struct CustomLabel: View {
    
    // MARK: - Internal Properties
    var labelText: String
    var additionalText: String
    var color: Color = Pallete.BlackWhite.black
    var secondColor: Color = Pallete.Gray.forText
    var fontStyle: FontStyle = .main
    
    // MARK: - Body
    var body: some View {
        VStack{
            switch fontStyle {
            case .main:
                Text(labelText)
                    .font(.system(size: 16))
                    .foregroundColor(color)
                
            case .second:
                Text(additionalText)
                    .font(.system(size: 14))
                    .foregroundColor(secondColor)
                
            @unknown default:
                Text(labelText)
            }
        }
    }
}

enum FontStyle: String {
    case main, second
}

