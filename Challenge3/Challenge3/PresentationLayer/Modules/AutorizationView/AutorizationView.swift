//
//  AuthorizationView.swift
//

import SwiftUI
import _AuthenticationServices_SwiftUI

struct AuthorizationView: View, ItemView {

    // MARK: - Internal Properties
    var listener: CustomNavigationContainer?

    // MARK: - Property Wrappers
    @EnvironmentObject var viewModel: AuthenticationViewModel
   
    
    // MARK: - Private Properties
    private var strings = Localizable.Autorization.self

    // MARK: - Body
    var body: some View {
        VStack {
            
            Spacer()
            
            LoginTextField(inputText: $viewModel.email, title: strings.enterLogin, placeHolder: strings.login, withHideOption: false, withBorder: false, cornerRadius: 12, backgroundColor: Pallete.Gray.forTextFields)
              
                
            LoginTextField(inputText: $viewModel.password, isSecure: true, title: strings.enterPassword, placeHolder: strings.password, withHideOption: true, withBorder: false, cornerRadius: 12, backgroundColor: Pallete.Gray.forTextFields)
            
            Text(viewModel.errorMessage)
                .foregroundColor(Pallete.Other.pink)
            
            CustomButton(title: strings.logIn, cornerRadius: 100, buttonType: .filledBlue){ 
                signInWithEmail()
            }
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
                signInWithGoogle()
            }
            
            SignInWithAppleButton(.signIn) { request in
                
                viewModel.handleSignInWithAppleRequest(request)
            } onCompletion: { result in
                viewModel.handleSignInWithAppleCompletion(result)
            }
                .frame(width: 400, height: 60)
                .clipShape(RoundedCorners(radius: 50))

            Spacer()
            
            HStack {
                Spacer()
                
                Text(strings.dontHaveAccount)
                    .font(.system(size: 16))
                
                StringButton(title: strings.signIn, font: .system(size: 16), foregroundColor: Pallete.Other.green){}
                
                Spacer()
            }
        }
    }
    
   func signInWithEmail() {
        Task {
            if await viewModel.signInWithEmailPassword(){
                listener?.pop()
            }
        }
    }
    
    func signInWithGoogle() {
        Task {
            if await viewModel.signInWithGoogle(){
                listener?.pop()
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
