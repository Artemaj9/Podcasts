//
//  CreateAccountWithEmail.swift
//

import SwiftUI

struct CreateWithEmailView: View, ItemView {

    @EnvironmentObject var viewModel: CreateWithEmailViewModel
    
    var listener: CustomNavigationContainer?
    
    var body: some View {
  
        ScrollView{
            
            VStack{

                CustomLabel(labelText: Localizable.CreateAccount.CreateWithEmail.complete, additionalText: Localizable.CreateAccount.CreateWithEmail.signUpAdit, labelStyle: .create, epsText: "")

                LoginTextField(inputText: $viewModel.firstName, title: Localizable.CreateAccount.CreateWithEmail.firstName, placeHolder: Localizable.CreateAccount.CreateWithEmail.firstNameField, withHideOption: false, withBorder: false, cornerRadius: 24, backgroundColor: Pallete.Gray.forTextFields)

                LoginTextField(inputText: $viewModel.lastName, title: Localizable.CreateAccount.CreateWithEmail.lastName, placeHolder: Localizable.CreateAccount.CreateWithEmail.lastNameField, withHideOption: false, withBorder: false, cornerRadius: 24, backgroundColor: Pallete.Gray.forTextFields)

                LoginTextField(inputText: $viewModel.email, title: Localizable.CreateAccount.CreateWithEmail.email, placeHolder: Localizable.CreateAccount.CreateWithEmail.emailField, withHideOption: false, withBorder: false, cornerRadius: 24, backgroundColor: Pallete.Gray.forTextFields)

                LoginTextField(inputText: $viewModel.password, title: Localizable.CreateAccount.CreateWithEmail.password, placeHolder: Localizable.CreateAccount.CreateWithEmail.passwordFiled, withHideOption: true, withBorder: false, cornerRadius: 24, backgroundColor: Pallete.Gray.forTextFields)

                LoginTextField(inputText: $viewModel.confpassword, title: Localizable.CreateAccount.CreateWithEmail.confPassword, placeHolder: Localizable.CreateAccount.CreateWithEmail.confPasswordFiled, withHideOption: true, withBorder: false, cornerRadius: 24, backgroundColor: Pallete.Gray.forTextFields)

                CustomButton(title: Localizable.CreateAccount.CreateWithEmail.signUp, font: (.system(size: 16)), buttonType: .filledBlue, action: {
                        listener?.push(view: OnboardingView())
                    })

                    HStack{
                        Text(Localizable.CreateAccount.CreateWithEmail.alreadyHave)
                        
                        StringButton(title: Localizable.CreateAccount.CreateWithEmail.login, font: (.system(size: 16)), foregroundColor: .green, action: {
                            listener?.push(view: AutorizationView())
                        })
                    }
            }
        }
        .makeCustomNavBar {
            NavigationBars(atView: .signUp, leadingButtonAction: {
                listener?.pop()
            })
        }
    }
}

struct CreatetWithEmailView_Previews: PreviewProvider {
    static var previews: some View {
        CreateWithEmailView()
            .environmentObject(CreateWithEmailViewModel())
    }
}
