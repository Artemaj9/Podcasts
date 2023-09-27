//
//  testView.swift
//

// DELETE AFTER INTEGRATING ON VIEWS

import SwiftUI
import Combine

struct testView: View, ItemView {
    @EnvironmentObject var viewModel: AuthenticationModel
    @Environment(\.dismiss) var dismiss
    
    var listener: CustomNavigationContainer?
    
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
    
    var body: some View {
        VStack {
            Button {
                signInWithEmail()
            } label: {
                Text("SignUp with email")
            }
            
            Button {
                signInWithGoogle()
            } label: {
                Text("SignUp with google")
            }
        }
    }
}

struct testView_Previews: PreviewProvider {
    static var previews: some View {
        testView()
    }
}
