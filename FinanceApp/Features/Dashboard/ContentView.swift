//
//  ContentView.swift
//  FinanceApp
//
//  Created by Ibira Junior on 03/06/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome, \(authViewModel.user?.email ?? "User")")
                Button("Sign Out") {
                    authViewModel.signOut()
                }
                .buttonStyle(.bordered)
            }
            .navigationTitle("Finely Dashboard")
        }
    }
}

#Preview {
    ContentView().environmentObject(AuthViewModel(authService: FirebaseService()))
}
