//
//  CreateAccountWithEmail.swift
//

import SwiftUI

struct CreateWithEmailView: View, ItemView {
    
    @StateObject var viewModel: CreateWithEmailViewModel
    
    var listener: CustomNavigationContainer?
    
    var body: some View {
  
        ScrollView{
            
            VStack{

                CustomLabel(labelText: Localizable.Autorization.signUp, additionalText: Localizable.Autorization.signUpAdit, labelStyle: .create, epsText: "")

                LoginTextField(inputText: viewModel.firstName, title: Localizable.Autorization.firstName, placeHolder: Localizable.Autorization.firstNameField, withHideOption: false, withBorder: false, cornerRadius: 24, backgroundColor: Pallete.Gray.forTextFields)

                LoginTextField(inputText: viewModel.lastName, title: Localizable.Autorization.lastName, placeHolder: Localizable.Autorization.lastNameField, withHideOption: false, withBorder: false, cornerRadius: 24, backgroundColor: Pallete.Gray.forTextFields)

                LoginTextField(inputText: viewModel.email, title: Localizable.Autorization.email, placeHolder: Localizable.Autorization.emailField, withHideOption: false, withBorder: false, cornerRadius: 24, backgroundColor: Pallete.Gray.forTextFields)

                LoginTextField(inputText: viewModel.password, title: Localizable.Autorization.password, placeHolder: Localizable.Autorization.passwordFiled, withHideOption: true, withBorder: false, cornerRadius: 24, backgroundColor: Pallete.Gray.forTextFields)

                LoginTextField(inputText: viewModel.confpassword, title: Localizable.Autorization.confPassword, placeHolder: Localizable.Autorization.confPasswordFiled, withHideOption: true, withBorder: false, cornerRadius: 24, backgroundColor: Pallete.Gray.forTextFields)

                CustomButton(title: Localizable.Autorization.signUp, font: (.system(size: 16)), buttonType: .filledBlue, action: {
                        listener?.push(view: OnboardingView())
                    })

                    HStack{
                        Text(Localizable.Autorization.alreadyHave)
                        
                        StringButton(title: Localizable.Autorization.login, font: (.system(size: 16)), foregroundColor: .green, action: {
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
        CreateWithEmailView(viewModel: CreateWithEmailViewModel())
    }
}
