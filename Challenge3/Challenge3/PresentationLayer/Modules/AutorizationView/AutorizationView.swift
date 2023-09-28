//
//  AuthorizationView.swift
//

import SwiftUI

struct AuthorizationView: View {

    // MARK: - Internal Properties
    var listener: CustomNavigationContainer?

    // MARK: - Property Wrappers
    @EnvironmentObject var authorizarionViewModel: AuthorizarionViewModel

    // MARK: - Private Properties
    private var strings = Localizable.Autorization.self

    // MARK: - Body
    var body: some View {
        VStack {
            
            Spacer()
            
            LoginTextField(inputText: authorizarionViewModel.login, title: strings.enterLogin, placeHolder: strings.login, withHideOption: false, withBorder: false, cornerRadius: 12, backgroundColor: Pallete.Gray.forTextFields)
            
            LoginTextField(inputText: authorizarionViewModel.password, isSecure: false, title: strings.enterPassword, placeHolder: strings.password, withHideOption: true, withBorder: false, cornerRadius: 12, backgroundColor: Pallete.Gray.forTextFields)
            
            CustomButton(title: strings.logIn, cornerRadius: 100, buttonType: .filledBlue, action: {})
                .frame(height: 62)
            
            HStack {
                Rectangle()
                    .frame(width: 62, height: 1)
                
                Text(strings.continueWith)
                
                Rectangle()
                    .frame(width: 62, height: 1)
                
            }
            .foregroundColor(Pallete.BlackWhite.black)
            .padding(32)
            
            CustomButton(title: strings.signInWithGoogle, buttonType: .outGoogle) {

            }
            
            CustomButton(title: strings.signInWithApple, buttonType: .outApple) {

            }

            Spacer()
            
            HStack {
                Spacer()
                
                Text(strings.dontHaveAccount)
                    .font(.system(size: 12))
                
                StringButton(title: strings.signIn, font: .system(size: 12), foregroundColor: Pallete.Other.green, action: {})
                
                Spacer()
            }
            
        }
    }
}


struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationView()
            .environmentObject(AuthorizarionViewModel())
    }
}
