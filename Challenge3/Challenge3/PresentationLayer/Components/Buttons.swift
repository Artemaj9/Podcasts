//
//  Buttons.swift
//

import SwiftUI

enum RoundedButtonState {
    case filledBlue
    case blackBlue
    case filledGray
    case blankBlack
    case outGoogle
}

struct Buttons: View {
    
    @State var select = false
    
    var body: some View {
        
        VStack {
            CustomButton(title: "Войти",buttonType: .filledBlue) {}
            
            CustomButton(title: "Log Out",buttonType: .blackBlue) {}
            
            CustomButton(title: "Save Changes",buttonType: .filledGray) {}
            
            CustomButton(title: "Select from local files",buttonType:.blankBlack) {}
            
            CustomButton(title: "Continue with Google",buttonType: .outGoogle) {}
            
            StrokeButton(title: "Зарегестрироваться",foregroundColor: .green) {}
            
            BackButton(isReverse: true) {}
            
            GenresButton(title: "Comedy") {}
        }
    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        Buttons()
    }
}
struct CustomButton: View {
    var title: String
    var font: Font = .system(size: 20)
    var cornerRadius: Double = 50
    var padding: Double = 16
    var buttonType: RoundedButtonState = .filledBlue
    
    var action: () -> Void
    
    var body: some View {
        switch buttonType {
        case .outGoogle:
            Button(action: action) {
                HStack {
                    Spacer()
                    
                    Image(Images.Icon.iconGoogle.rawValue)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .padding(.trailing, 8)
                    
                    Text(title)
                        .font(font)
                    
                    Spacer()
                }
                .padding(padding)
                .font(font)
                .background(.white)
                .foregroundColor(.black)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(Color.black, lineWidth: 2)
                )
                .padding()
            }
            
        case .filledGray:
            ZStack {
                Button(action: action) {
                    Text(title)
                        .frame(maxWidth: .infinity)
                        .padding(padding)
                        .font(font)
                        .background(Pallete.Gray.forButton)
                        .foregroundColor(.gray)
                        .cornerRadius(cornerRadius)
                }
            }
            .padding()
            
        case .blackBlue:
            ZStack {
                Button(action: action) {
                    Text(title)
                        .frame(maxWidth: .infinity)
                        .padding(padding)
                        .font(font)
                        .background(.white)
                        .foregroundColor(.blue)
                        .cornerRadius(cornerRadius)
                        .overlay(
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .stroke(Color.blue, lineWidth: 2)
                        )
                }
            }
            .padding()
            
        case .filledBlue:
            Button(action: action) {
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.blue)
                    
                    Text(title)
                        .padding()
                        .font(font)
                        .foregroundColor(.white)
                }
            }
            .padding()
            
        case .blankBlack:
            HStack {
                Spacer()
                
                Image(Images.Icon.folder.rawValue)
                    .resizable()
                    .frame(width: 20, height: 20)
                    .padding(.trailing, 8)
                
                Text(title)
                    .font(font)
                
                Spacer()
            }
            .padding(padding)
            .font(font)
            .background(Pallete.Gray.forCells)
            .foregroundColor(.black)
            .cornerRadius(cornerRadius)
            .padding()
            
        }
    }
}

struct StrokeButton: View {
    var title: String
    var font: Font = .system(size: 20)
    var foregroundColor: Color = .black
    var background: Color = .white
    
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(font)
                .background(background)
                .foregroundColor(foregroundColor)
        }
    }
}

struct BackButton: View {
    var isReverse: Bool = false
    var background: Color = .gray
    var padding: Double = 10
    
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(Images.Icon.arrowLeft.rawValue)
                    .padding(.horizontal)
            }
            .padding(padding)
            .background(isReverse ? background : .clear)
            .clipShape(Circle())
        }
    }
}

struct GenresButton: View {
    var title: String
    var font: Font = .system(size: 20)
    var cornerRadius: Double = 10
    var padding: Double = 50
    
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            ZStack {
                Button(action: action) {
                    Text(title)
                        .padding(padding)
                        .font(font)
                        .background(.pink)
                        .foregroundColor(.white)
                        .cornerRadius(cornerRadius)
                }
            }
            .padding()
        }
    }
}

