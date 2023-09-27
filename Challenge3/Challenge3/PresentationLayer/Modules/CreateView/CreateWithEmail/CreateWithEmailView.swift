//
//  CreateAccountWithEmail.swift
//

import SwiftUI

struct CreateWithEmailView: View, ItemView {
    
    @StateObject var viewModel: CreateWithEmailViewModel
    
    var listener: CustomNavigationContainer?
    
    var body: some View {
        ZStack {
            NavigationBars(atView: .signUp, leadingButtonAction: {}, trailingButtonAction: {})
            
            VStack{
                
                
                Spacer()
                CustomLabel(labelText: "Complete your account", additionalText: "for continue", labelStyle: .create, epsText: "")
                Spacer()
                LoginTextField(inputText: viewModel.firstName, title: "First name", placeHolder: "Enter your first name", withHideOption: false, withBorder: false, cornerRadius: 24, backgroundColor: Pallete.Gray.forTextFields)
                Spacer()
                LoginTextField(inputText: viewModel.lastName, title: "Last name", placeHolder: "Enter your last name", withHideOption: false, withBorder: false, cornerRadius: 24, backgroundColor: Pallete.Gray.forTextFields)
                Spacer()
                LoginTextField(inputText: viewModel.email, title: "E-mail", placeHolder: "Enter your email", withHideOption: false, withBorder: false, cornerRadius: 24, backgroundColor: Pallete.Gray.forTextFields)
                Spacer()
                LoginTextField(inputText: viewModel.password, title: "Password", placeHolder: "Enter your password", withHideOption: true, withBorder: false, cornerRadius: 24, backgroundColor: Pallete.Gray.forTextFields)
                Spacer()
                LoginTextField(inputText: viewModel.confpassword, title: "Confirm password", placeHolder: "Confirm your password", withHideOption: true, withBorder: false, cornerRadius: 24, backgroundColor: Pallete.Gray.forTextFields)
                Spacer()
                CustomButton(title: "Sign up", font: (.system(size: 16)), buttonType: .filledBlue, action: {})
                Spacer()
                HStack{
                    Text("Already have an account?")
                    
                    StringButton(title: "Login", font: (.system(size: 16)), foregroundColor: .green, action: {})
                }
                
                Spacer()
            }
        }
    }
}

struct CreatetWithEmailView_Previews: PreviewProvider {
    static var previews: some View {
        CreateWithEmailView(viewModel: CreateWithEmailViewModel())
    }
}
