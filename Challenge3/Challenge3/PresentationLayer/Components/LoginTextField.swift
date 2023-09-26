//
//  LoginTextField.swift
//

import SwiftUI

struct LoginTextField: View {

    @State var inputText: String
    @State var isSecure: Bool = false
    @FocusState var isFocused: Bool

    let title: String
    let placeHolder: String
    let withHideOption: Bool
    let withBorder: Bool
    let cornerRadius: CGFloat

    var body: some View {

        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .fontWeight(.light)
                .padding(.leading)
            ZStack(alignment: .trailing) {
                Group {
                    if isSecure {
                    SecureField(placeHolder, text: $inputText)
                     } else {
                    TextField(placeHolder, text: $inputText)
                }
            }
        }
                .focused($isFocused)
                .foregroundColor(Color.black)
                .disableAutocorrection(true)
                .frame(maxHeight: 24)
                .overlay(
                    ZStack {
                        Image(isSecure ? Images.Icon.hide.rawValue : Images.Icon.eye.rawValue)
                            .scaleEffect(isSecure ? 0.9 : 1.3)
                            .opacity(withHideOption ? 1 : 0)
                            .padding()
                            .onTapGesture {
                                isSecure.toggle()
                            }
                    }
                    ,alignment: .trailing)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: cornerRadius)
                       .fill(Color.white)
                       .overlay(
                                 RoundedRectangle(cornerRadius: cornerRadius)
                                    .stroke(Pallete.Blue.forAccent, lineWidth: withBorder ? 1 : 0)
                             )
                        .shadow(radius: isFocused ? 4 : 0)
                        .animation(.linear, value: isFocused)
                )
                .padding()
            }
        }
    }

    struct LoginTextField_Previews: PreviewProvider {
        static var previews: some View {
            ZStack {
                Pallete.Blue.forOnboarding.ignoresSafeArea()
                VStack {
                    LoginTextField(inputText: "",
                                   isSecure: true,
                                   title: "Login",
                                   placeHolder: "Login",
                                   withHideOption: true,
                                   withBorder: false,
                                   cornerRadius: 12)
                    LoginTextField(inputText: "",
                                   isSecure: false,
                                   title: "Password",
                                   placeHolder: "Enter your password",
                                   withHideOption: true,
                                   withBorder: false,
                                   cornerRadius: 12)
                    LoginTextField(inputText: "",
                                   title: " E-mail",
                                   placeHolder: "Email",
                                   withHideOption: false,
                                   withBorder: true,
                                   cornerRadius: 24)
                    LoginTextField(inputText: "",
                                   isSecure: true,
                                   title: "FirstName",
                                   placeHolder: "FirstName",
                                   withHideOption: true,
                                   withBorder: false,
                                   cornerRadius: 24)
                }
            }
        }
    }
