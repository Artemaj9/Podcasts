//
//  Buttons.swift
//

import SwiftUI

enum RoundedButtonState {
    case filledBlue
    case strokeBlue
    case filledGray
    case select
    case outGoogle
}

struct Buttons: View {
    
    @State var select = false
    
    var body: some View {
        
        VStack {
            CustomButton(title: "Войти",buttonType: .filledBlue) {}
            
            CustomButton(title: "Log Out",buttonType: .strokeBlue) {}
            
            CustomButton(title: "Save Changes",buttonType: .filledGray) {}
            
            CustomButton(title: "Select from local files",buttonType:.select) {}
            
            CustomButton(title: "Continue with Google",buttonType: .outGoogle) {}
            
            StringButton(title: "Зарегестрироваться",foregroundColor: .green) {}
            
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
    var buttonType: RoundedButtonState = .filledBlue
    
    var action: () -> Void
    
    var body: some View {
        switch buttonType {
        case .outGoogle:
            Button {
                action()
            } label: {
                HStack {
                    Spacer()
                    
                    Image(Images.Icon.iconGoogle.rawValue)
                        .resizable()
                        .frame(width: 20, height: 20)
                    
                    Text(title)
                        .font(font)
                    
                    Spacer()
                }
                .font(font)
                .background(.white)
                .foregroundColor(.black)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(Color.black, lineWidth: 2)
                )
                .padding()
            }
            
        case .filledGray:
            ZStack {
                Button {
                    action()
                } label: {
                    HStack {
                        Spacer()
                        Text(title)
                            .font(font)
                        Spacer()
                    }
                        .padding()
                        .background(Pallete.Gray.forButton)
                        .foregroundColor(.gray)
                        .cornerRadius(cornerRadius)
                }
            }
            .padding()
            
        case .strokeBlue:
            ZStack {
                Button {
                    action()
                } label: {
                    HStack {
                        Spacer()
                        Text(title)
                            .font(font)
                        Spacer()
                    }
                        .font(font)
                        .background(.white)
                        .foregroundColor(.blue)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .stroke(Color.blue, lineWidth: 2)
                        )
                }
            }
            .padding()
            
        case .filledBlue:
            Button {
                action()
            } label: {
                HStack {
                    Spacer()
                    Text(title)
                        .font(font)
                        .foregroundColor(.white)
                    Spacer()
                }
                    .padding(20)
                    .background( RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(.blue))
                }
            .padding()
            
        case .select:
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
            .padding()
            .background(Pallete.Gray.forCells)
            .foregroundColor(.black)
            .cornerRadius(cornerRadius)
            .padding()
            
        }
    }
}

struct StringButton: View {
    var title: String
    var font: Font = .system(size: 20)
    var foregroundColor: Color = .black
    var background: Color = .white
    
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
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
        Button {
            action()
        } label: {
            HStack {
                Image(Images.Icon.arrowLeft.rawValue)
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
    
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Button(action: action) {
                    Text(title)
                        .font(font)
                        .background(.pink)
                        .foregroundColor(.white)
                        .cornerRadius(cornerRadius)
                        .frame(alignment: .center)
                }
            }
            .padding()
        }
      }
    }

struct CreateButton: View {
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 12) {
                
                CustomIcon(iconString: Images.Icon.plus.rawValue, backColor: Pallete.OtherLight.peach,
                           width: 48, height: 48)
                
                Text(Localizable.Favorite.createPlaylist)
                    .foregroundColor(.black)
            }
        }
    }
}
