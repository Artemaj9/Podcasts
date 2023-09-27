//
//  AutorizationView.swift
//

import SwiftUI

struct AutorizationView: View {
    
    @StateObject var viewModel: AuthorizarionViewModel
    @State private var isActive: Bool = false
    
    // MARK: - Body
    var body: some View {
        VStack{
            
            Spacer()
            
            LoginTextField(inputText: viewModel.login, title: "Введите логин", placeHolder: "Логин", withHideOption: false, withBorder: false, cornerRadius: 12, backgroundColor: Pallete.Gray.forTextFields)
            
            LoginTextField(inputText: viewModel.password, isSecure: false, title: "Введите пароль", placeHolder: "Пароль", withHideOption: true, withBorder: false, cornerRadius: 12, backgroundColor: Pallete.Gray.forTextFields)
            
            CustomButton(title: "Войти", cornerRadius: 100, buttonType: .filledBlue, action: {})
                .frame(height: 62)
            
            HStack{
                Rectangle()
                    .frame(width: 62, height: 1)
                
                Text("Or continue with")
                
                Rectangle()
                    .frame(width: 62, height: 1)
                
            }.foregroundColor(Pallete.BlackWhite.black)
                .padding(32)
            
            CustomButton(title: "Sign in with Google", buttonType: .outGoogle, action: {} )
            
            Spacer()
            
            HStack{
                Spacer()
                
                Text("У вас еще нет аккаунта?")
                    .font(.system(size: 12))
                
                StringButton(title: "Зарегистрироваться", font: (.system(size: 12)), foregroundColor: .green, action: {})
                
                Spacer()
            }
            
        }.background(NavigationLink(destination: CreateWithEmailView(), isActive: $isActive) {
            EmptyView()
        })
        
    }
}




