//
//  LoginView.swift
//  FinanceApp
//
//  Created by Ibira Junior on 03/06/25.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var authViewModel: AuthViewModel

    
    var body: some View {
        NavigationStack{
            VStack(spacing: 20) {
                TextField("Email", text: $authViewModel.email)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Password", text: $authViewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if let error = authViewModel.error {
                    Text(error)
                        .foregroundColor(.red)
                }
                
                Button("Sign In") {
                    authViewModel.signIn()
                }
                .buttonStyle(.borderedProminent)
                
                NavigationLink("Create Account", destination: SignUpView())
                    .font(.caption)
                
                Spacer()
                
            }
            .padding()
            .navigationTitle("Login")
            
        }
        
    }
}

#Preview {
    LoginView()
}
