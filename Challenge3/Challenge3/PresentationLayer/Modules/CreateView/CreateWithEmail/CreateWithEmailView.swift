//
//  CreateAccountWithEmail.swift
//

import SwiftUI

struct CreateWithEmailView: View, ItemView {
    
    // MARK: - Property wrapers
    
    @ObservedObject var authViewModel = AuthenticationViewModel.shared
    @EnvironmentObject var splashViewModel: SplashViewModel
    
    // MARK: - Internal properties
    
    var listener: CustomNavigationContainer?
    
    // MARK: - View's body
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    CustomLabel(labelText: Localizable.CreateAccount.CreateWithEmail.complete, additionalText: Localizable.CreateAccount.CreateWithEmail.signUpAdit, labelStyle: .create, epsText: "")
                    
                    LoginTextField(inputText: $authViewModel.firstName, title: Localizable.CreateAccount.CreateWithEmail.firstName, placeHolder: Localizable.CreateAccount.CreateWithEmail.firstNameField, withHideOption: false, withBorder: false, cornerRadius: 24, backgroundColor: Pallete.Gray.forTextFields)
                    
                    LoginTextField(inputText: $authViewModel.lastName, title: Localizable.CreateAccount.CreateWithEmail.lastName, placeHolder: Localizable.CreateAccount.CreateWithEmail.lastNameField, withHideOption: false, withBorder: false, cornerRadius: 24, backgroundColor: Pallete.Gray.forTextFields)
                    
                    LoginTextField(inputText: $authViewModel.email, title: Localizable.CreateAccount.CreateWithEmail.email, placeHolder: Localizable.CreateAccount.CreateWithEmail.emailField, withHideOption: false, withBorder: false, cornerRadius: 24, backgroundColor: Pallete.Gray.forTextFields)
                    
                    LoginTextField(inputText: $authViewModel.password, isSecure: true, title: Localizable.CreateAccount.CreateWithEmail.password, placeHolder: Localizable.CreateAccount.CreateWithEmail.passwordFiled, withHideOption: true, withBorder: false, cornerRadius: 24, backgroundColor: Pallete.Gray.forTextFields)
                    
                    LoginTextField(inputText: $authViewModel.confirmPassword, isSecure: true, title: Localizable.CreateAccount.CreateWithEmail.confPassword, placeHolder: Localizable.CreateAccount.CreateWithEmail.confPasswordFiled, withHideOption: true, withBorder: false, cornerRadius: 24, backgroundColor: Pallete.Gray.forTextFields)
                    
                    Text(authViewModel.errorMessage)
                        .foregroundColor(Pallete.Other.pink)
                    
                    CustomButton(title: Localizable.CreateAccount.CreateWithEmail.signUp, font: (.system(size: 16)), buttonType: .filledBlue) {
                        signUpWithEmail()
                    }
                    
                    HStack {
                        Text(Localizable.CreateAccount.CreateWithEmail.alreadyHave)
                        
                        StringButton(title: Localizable.CreateAccount.CreateWithEmail.login, font: (.system(size: 16)), foregroundColor: .green) {
                            listener?.popToRoot()
                        }
                    }
                }
            }
            .makeCustomNavBar {
                NavigationBars(atView: .signUp) {
                    listener?.pop()
                }
            }
        }
    }
    private func signUpWithEmail() {
        Task {
            if await authViewModel.signUpWithEmailPassword() {
                authViewModel.changeDisplayName()
                splashViewModel.isNotLoggedIn = true
                listener?.push(view: OnboardingView())
            }
        }
    }
}

struct CreatetWithEmailView_Previews: PreviewProvider {
    static var previews: some View {
        CreateWithEmailView()
            .environmentObject(CreateWithEmailViewModel())
            .environmentObject(SplashViewModel())
    }
}
