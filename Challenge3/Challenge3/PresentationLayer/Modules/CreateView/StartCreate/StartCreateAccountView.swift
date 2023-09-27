//
//  StartCreateAccountView.swift
//

import SwiftUI

struct StartCreateAccountView: View, ItemView {
    var listener: CustomNavigationContainer?
    
    var body: some View {
        ZStack {
            Pallete.Blue.forAccent.ignoresSafeArea()
            VStack {
                Group {
                    Text(Localizable.CreateAccount.StartCreate.navTitle)
                        .fontWeight(.bold)
                        .font(.title)
                        .padding(.top, 64)
                        .padding(.bottom, 8)
                    Text("Lorem ipsum dolor sit amet")
                        .font(.title3)
                        .padding(.bottom, 60)
                }
                .foregroundColor(.white)
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .ignoresSafeArea(.all, edges: .bottom)
                        .foregroundColor(.white)
                    VStack(spacing: 8) {
                        LoginTextField(inputText: "",
                                       title: Localizable.CreateAccount.StartCreate.email,
                                       placeHolder: Localizable.CreateAccount.StartCreate.enterEmail,
                                       withHideOption: false,
                                       withBorder: false,
                                       cornerRadius: 24,
                                       backgroundColor: Pallete.Gray.forTextFields)
                        
                        VStack(spacing: 16) {
                            CustomButton(title: Localizable.CreateAccount.StartCreate.contWithEmail,
                            buttonType: .filledBlue) {}
                                                        
                            Text(Localizable.CreateAccount.StartCreate.orContWith)
                                .foregroundColor(Pallete.Gray.forText)
                            
                            CustomButton(title: Localizable.CreateAccount.StartCreate.contWithGoogle,
                            buttonType: .outGoogle) {}
                        }
                        Spacer()
                        HStack {
                            Text(Localizable.CreateAccount.StartCreate.already)
                                .minimumScaleFactor(0.7)
                            StringButton(title: Localizable.CreateAccount.StartCreate.login,foregroundColor: .green) {}
                        }
                        Spacer()
                    }
                    .padding(.top, 36)
                }
            }
        }
    }
}

struct StartCreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        StartCreateAccountView()
    }
}
