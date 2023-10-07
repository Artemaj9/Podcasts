//
//  AuthorizationView.swift
//

import SwiftUI
import _AuthenticationServices_SwiftUI

struct AuthorizationView: View, ItemView {
    
    // MARK: - Property Wrappers
    
    @ObservedObject var authViewModel = AuthenticationViewModel.shared
    @EnvironmentObject var splashViewModel: SplashViewModel
    
    // MARK: - Internal Properties
    
    var listener: CustomNavigationContainer?
    
    // MARK: - Private Properties
    
    private var strings = Localizable.Autorization.self
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            
            Spacer()
            
            LoginTextField(inputText: $authViewModel.email, title: strings.enterLogin, placeHolder: strings.login, withHideOption: false, withBorder: false, cornerRadius: 12, backgroundColor: Pallete.Gray.forTextFields)
            
            LoginTextField(inputText: $authViewModel.password, isSecure: true, title: strings.enterPassword, placeHolder: strings.password, withHideOption: true, withBorder: false, cornerRadius: 12, backgroundColor: Pallete.Gray.forTextFields)
            
            Text(authViewModel.errorMessage)
                .foregroundColor(Pallete.Other.pink)
            
            CustomButton(title: strings.logIn, cornerRadius: 100, buttonType: .filledBlue) {
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
                authViewModel.handleSignInWithAppleRequest(request)
            } onCompletion: { result in
                authViewModel.handleSignInWithAppleCompletion(result)
            }
            .frame(height: 60)
            .clipShape(RoundedCorners(radius: 50))
            .padding(.horizontal)
            
            Spacer()
            
            HStack {
                Spacer()
                
                Text(strings.dontHaveAccount)
                    .font(.system(size: 16))
                
                StringButton(title: strings.signIn, font: .system(size: 16), foregroundColor: Pallete.Other.green) {
                    listener?.push(view: StartCreateAccountView())
                }
                
                Spacer()
            }
        }
    }
    
    func signInWithEmail() {
        Task {
            if await authViewModel.signInWithEmailPassword() {
                splashViewModel.isNotLoggedIn = true
                listener?.push(view: MainTabBar())
            }
        }
    }
    
    func signInWithGoogle() {
        Task {
            if await authViewModel.signInWithGoogle() {
                listener?.push(view: MainTabBar())
            }
        }
    }
}

struct AuthorizationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorizationView()
            .environmentObject(AuthorizarionViewModel())
            .environmentObject(SplashViewModel())
    }
}
