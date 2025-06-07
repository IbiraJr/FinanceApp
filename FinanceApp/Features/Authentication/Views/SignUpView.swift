//
//  SignUpView.swift
//  FinanceApp
//
//  Created by Ibira Junior on 03/06/25.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss
    
    @State private var confirmPassword: String = ""
    
    var body: some View {
        VStack(spacing: 20){
            TextField("Email", text: $authViewModel.email)
                .autocapitalization(.none)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Password", text: $authViewModel.password)
                .textFieldStyle(.roundedBorder)
            
            SecureField("Confirm Password", text: $confirmPassword)
                .textFieldStyle(.roundedBorder)
            
            if let error = authViewModel.error {
                Text(error)
                    .foregroundColor(.red)
            }
            
            Button("Create Account"){
                guard authViewModel.password == confirmPassword else {
                    authViewModel.error = "Passwords do not match"
                    return
                }
                
                authViewModel.signUp()
                
            }
            .buttonStyle(.borderedProminent)
            
            Button("Already have an account? Log in"){
                dismiss()
            }
            .font(.caption)
            Spacer()
        }
        .padding()
        .navigationTitle("Sign Up")
    }
}

#Preview {
    SignUpView()
}
