//
//  StartCreateAccountView.swift
//

import SwiftUI
import _AuthenticationServices_SwiftUI

struct StartCreateAccountView: View, ItemView {
    @EnvironmentObject var viewModel: AuthenticationViewModel
    @EnvironmentObject var splashViewModel: SplashViewModel

    var listener: CustomNavigationContainer?
    
    var body: some View {
        ZStack {
            Pallete.Blue.forAccent.ignoresSafeArea()
            VStack {
                Group {
                    Text(Localizable.CreateAccount.StartCreate.navTitle)
                        .fontWeight(.bold)
                        .font(.title)
                        .padding(.bottom, 8)
                        .padding(.top, 64)
                    Text(Localizable.CreateAccount.StartCreate.greeting)
                        .font(.title3)
                        .padding(.bottom, 60)
                }
                .foregroundColor(.white)
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .foregroundColor(.white)
                    VStack(spacing: 8) {
                        LoginTextField(inputText: $viewModel.email,
                                       title: Localizable.CreateAccount.StartCreate.email,
                                       placeHolder: Localizable.CreateAccount.StartCreate.enterEmail,
                                       withHideOption: false,
                                       withBorder: false,
                                       cornerRadius: 24,
                                       backgroundColor: Pallete.Gray.forTextFields)
                        
                        VStack(spacing: 16) {
                            CustomButton(title: Localizable.CreateAccount.StartCreate.contWithEmail,
                                         buttonType: .filledBlue) {
                                listener?.push(view: CreateWithEmailView())
                            }

                            Text(Localizable.CreateAccount.StartCreate.orContWith)
                                .foregroundColor(Pallete.Gray.forText)
                            
                            CustomButton(title: Localizable.CreateAccount.StartCreate.contWithGoogle,
                                         buttonType: .outGoogle) {
                                signInWithGoogle()
                            }
                            
                            SignInWithAppleButton(.signIn) {
                                
                                request in viewModel.handleSignInWithAppleRequest(request)
                            } onCompletion: { result in
                                viewModel.handleSignInWithAppleCompletion(result)
                            }
                            .frame(height: 60)
                            .clipShape(RoundedCorners(radius: 50))
                            .padding(.horizontal)
                            
                        }
                        Spacer()
                        HStack {
                            Text(Localizable.CreateAccount.StartCreate.already)
                                .minimumScaleFactor(0.7)
                            StringButton(title: Localizable.CreateAccount.StartCreate.login,foregroundColor: .green) {
                                listener?.pop()
                            }
                        }
                        Spacer()
                        Spacer()
                    }
                    .padding(.top, 36)
                }
                .offset(y: 8)
                .ignoresSafeArea(.all, edges: .bottom)
            }
        }
    }
    private func signInWithGoogle() {
        Task {
            if await viewModel.signInWithGoogle() {
                splashViewModel.isNotLoggedIn = true
                listener?.push(view: HomePageView())
            }
        }
    }
}

struct StartCreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        StartCreateAccountView()
            .environmentObject(SplashViewModel())
    }
}
