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
    var labelStyle: LabelStyle = .create
    var epsText: String
    
    // MARK: - Body
    var body: some View {
        
        switch labelStyle {
        case .create:
            VStack(alignment: .center, spacing: 8) {
                Text(labelText)
                    .font(.system(size: 24))
                    .foregroundColor(color)
                Text(additionalText)
                    .font(.system(size: 16))
                    .foregroundColor(secondColor)
            }
        case .homepage:
            VStack(alignment: .leading, spacing: 4) {
                Text(labelText)
                    .font(.system(size: 16))
                    .foregroundColor(color)
                Text(additionalText)
                    .font(.system(size: 14))
                    .foregroundColor(secondColor)
            }
            
        case .nowPlaying:
            VStack(alignment: .center, spacing: 5) {
                Text(labelText)
                    .font(.system(size: 16))
                    .foregroundColor(color)
                Text(additionalText)
                    .font(.system(size: 14))
                    .foregroundColor(secondColor)
            }
        
        case .channel:
            VStack(alignment: .center, spacing: 5) {
                Text(labelText)
                    .font(.system(size: 16))
                    .foregroundColor(color)
                HStack{
                    Text(additionalText)
                        .font(.system(size: 14))
                        .foregroundColor(secondColor)
                    Text(epsText)
                        .font(.system(size: 14))
                        .foregroundColor(secondColor)
                }
            }
        @unknown default:
            Text(labelText)
        }
        
    }
}

enum LabelStyle: String {
    case create, homepage, nowPlaying, channel
}

