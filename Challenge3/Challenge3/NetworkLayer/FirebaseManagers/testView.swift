//
//  testView.swift
//

// DELETE AFTER INTEGRATING ON VIEWS

import SwiftUI
import Combine
import AuthenticationServices

struct testView: View, ItemView {
    @EnvironmentObject var viewModel: AuthenticationModel
    @Environment(\.dismiss) var dismiss
    
    var listener: CustomNavigationContainer?
    
    private func signUpWithEmail() {
        Task {
            if await viewModel.signUpWithEmailPassword() == true {
                dismiss()
            }
        }
    }
    
    private func signInWithEmail() {
        Task {
            if await viewModel.signInWithEmailPassword() == true {
                dismiss()
            }
        }
    }
    
    private func signInWithGoogle() {
        Task {
            if await viewModel.signInWithGoogle() == true {
                dismiss()
            }
        }
    }
    
    private func signOut() {
        Task {
            viewModel.signOut()
        }
    }
    
    var body: some View {
        VStack(spacing: 30) {
            Group {
                TextField("Email", text: $viewModel.email)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .submitLabel(.next)
                
                TextField("Password", text: $viewModel.password)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .submitLabel(.next)
                
                TextField("Confirm password", text: $viewModel.confirmPassword)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .submitLabel(.go)
                    .onSubmit {
                        signUpWithEmail()
                    }
            }
            
            Button {
                signUpWithEmail()
            } label: {
                Text("SignUp with email")
            }
            
            Button {
                signInWithEmail()
            } label: {
                Text("SignIn with email")
            }
            
            Button {
                signInWithGoogle()
            } label: {
                Text("SignUp with google")
            }
            
            SignInWithAppleButton(.signIn) { request in viewModel.handleSignInWithAppleRequest(request)
            } onCompletion: { result in
                viewModel.handleSignInWithAppleCompletion(result)
            }
            .frame(width: 300, height: 80)
            
            Button {
                signOut()
            } label: {
                Text("Sign Out")
            }
        }
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView()
    }
}
