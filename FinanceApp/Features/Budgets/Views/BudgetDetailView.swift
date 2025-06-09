//
//  BudgetDetailView.swift
//  FinanceApp
//
//  Created by Ibira Junior on 07/06/25.
//

import SwiftUI

struct BudgetDetailView: View {
    @ObservedObject var viewModel: BudgetDetailViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $viewModel.budget.title)
                TextField("Value", value: $viewModel.budget.totalValue, format: .number)
                    .keyboardType(.decimalPad)
            }
            
            Section {
                Button("Save") {
                    viewModel.update()
                    dismiss()
                    
                }
                .disabled(!viewModel.hasChanges)
                
                Button("Delete Budget", role: .destructive) {
                    viewModel.delete()
                    dismiss()
                }
            }
        }
        .navigationTitle("Details")
    }
}

