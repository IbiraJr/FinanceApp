//
//  BudgetsView.swift
//  FinanceApp
//
//  Created by Ibira Junior on 03/06/25.
//

import SwiftUI

struct BudgetsView: View {
    @StateObject var viewModel: BudgetViewModel
    
    var body: some View {
        NavigationView {
            content
                .navigationTitle("Budgets")
        }
    }
    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressView("Loading...")
        } else if let error = viewModel.errorMessage {
            Text("Error: \(error)")
                .foregroundColor(.red)
        } else {
            if viewModel.budgets.isEmpty {
                Text("No budgets found.")
                    .foregroundColor(.gray)
            }
            else {
                List(viewModel.budgets) { budget in
                    
                    NavigationLink(destination: UpdateBudgetView(budget: budget)) {
                        VStack(alignment: .leading) {
                            Text(budget.title)
                                .font(.headline)
                            
                            Text("\(budget.totalValue, format: .currency(code: "USD"))")
                                .font(.subheadline)
                            
                            Text(budget.createdAt, style: .date)
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                        }
                        
                    }
                    .swipeActions {
                        Button(role: .destructive) {
                            viewModel.deleteBudget(budget)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
                    
                }
                
            }
            
        }
        
    }
}
