//
//  Label.swift
//


import SwiftUI

struct CustomLabel: View {
    
    // MARK: - Internal Properties
    var labelText: String
    var additionalText: String
    var color: Color = Pallete.Other.deepPurpleText
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
        case .cellHomepage:
            VStack(alignment: .leading, spacing: 4) {
                Text(labelText)
                    .font(.system(size: 20))
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
                HStack {
                    Text(additionalText)
                        .font(.system(size: 14))
                        .foregroundColor(secondColor)
                    RoundedRectangle(cornerRadius: 5)
                        .fill(secondColor)
                        .frame(width: 1, height: 16)
                    Text(epsText)
                        .font(.system(size: 14))
                        .foregroundColor(secondColor)
                }
            }
        case .searchResult:
            VStack(alignment: .leading, spacing: 5) {
                Text(labelText)
                    .font(.system(size: 16))
                    .foregroundColor(Pallete.Other.deepPurpleText)
                HStack {
                    Text(additionalText)
                        .font(.system(size: 14))
                        .foregroundColor(secondColor)
                    RoundedRectangle(cornerRadius: 5)
                        .fill(secondColor)
                        .frame(width: 1, height: 16)
                    Text(epsText)
                        .font(.system(size: 14))
                        .fontWeight(.semibold)
                        .foregroundColor(Pallete.Gray.darkerForText)
                }
            }
        @unknown default:
            Text(labelText)
        }
    }
}

enum LabelStyle: String {
    case create, cellHomepage, homepage, nowPlaying, channel, searchResult
}
