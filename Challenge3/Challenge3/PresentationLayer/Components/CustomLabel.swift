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
    var sizeLabel: Double = 16
    var sizeAddit: Double = 14
    
    // MARK: - Body
    var body: some View {
        VStack{
            switch fontStyle {
            case .main:
                Text(labelText)
                    .font(.system(size: sizeLabel))
                    .foregroundColor(color)
                
            case .second:
                Text(additionalText)
                    .font(.system(size: sizeAddit))
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

