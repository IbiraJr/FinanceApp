//
//  RootView.swift
//  FinanceApp
//
//  Created by Ibira Junior on 03/06/25.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
   
    var body: some View {
        content
            .transition(.opacity)
            .animation(.easeOut, value: authViewModel.user != nil)
    }

    @ViewBuilder
    private var content: some View {
        if authViewModel.isLoading {
            ProgressView("Loading...")
        } else if let user = authViewModel.user {
            BudgetsView(viewModel: BudgetViewModel(userId: user.id))
        } else {
            LoginView()
        }
    }
}
