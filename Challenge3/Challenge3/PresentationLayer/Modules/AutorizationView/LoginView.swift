//
//  LoginView.swift
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack{
            LoginTextField(inputText: viewModel.login, isSecure: true, title: "Введите логин", placeHolder: "Логин", withHideOption: true, withBorder: false, cornerRadius: 12)
            
            LoginTextField(inputText: viewModel.password, isSecure: false, title: "Введите пароль", placeHolder: "Пароль", withHideOption: true, withBorder: false, cornerRadius: 12)
        
            Butt
        }
    }
}

#Preview {
    LoginView(viewModel: LoginViewModel())
}
