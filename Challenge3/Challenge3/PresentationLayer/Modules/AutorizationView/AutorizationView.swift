//
//  AutorizationView.swift
//

import SwiftUI

struct AutorizationView: View {
    @StateObject var viewModel: AuthorizarionViewModel
    
    var body: some View {
        VStack{
            Spacer()
            LoginTextField(inputText: viewModel.login, title: "Введите логин", placeHolder: "Логин", withHideOption: false, withBorder: false, cornerRadius: 12)
            Spacer()
            LoginTextField(inputText: viewModel.password, isSecure: false, title: "Введите пароль", placeHolder: "Пароль", withHideOption: true, withBorder: false, cornerRadius: 12)
            Spacer()
            CustomButton(title: "Войти", cornerRadius: 100, buttonType: .filledBlue, action: {})
                .frame(height: 62)
            Spacer()
            HStack{
                Rectangle()
                    .frame(width: 62, height: 1)
                Text("Or continue with")
                Rectangle()
                    .frame(width: 62, height: 1)
            }.foregroundColor(Pallete.Gray.forNext)
            Spacer()
            CustomButton(title: "Sign in with Google", buttonType: .outGoogle, action: {} )
                
            Spacer()
            HStack{
                Spacer()
                Text("У вас еще нет аккаунта?")
                        .font(.system(size: 12))
                StringButton(title: "Зарегистрироваться", font: (.system(size: 12)), foregroundColor: .green, action: {})
                Spacer()
            }
            
        }
    }
}

#Preview {
    AutorizationView(viewModel: AuthorizarionViewModel())
}


