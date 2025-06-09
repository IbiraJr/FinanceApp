//
//  CreateBudgetView.swift
//  FinanceApp
//
//  Created by Ibira Junior on 07/06/25.
//

import SwiftUI

struct CreateBudgetView: View {
    @StateObject var viewModel: BudgetViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var title: String = ""
    @State private var value: String = ""
    
    var body: some View {
        
        Form {
            TextField("Title", text: $title)
                .textFieldStyle(.roundedBorder)
            
            TextField("Total Value", text: $value)
                .keyboardType(.numberPad)
                .textFieldStyle(.roundedBorder)
            
            Button("Save") {
                if let totalValue = Double(value) {
                    viewModel.createBudget(title: title, totalValue: totalValue)
                    dismiss()
                }
            }
        }
        .navigationTitle("Create Budget")
    }
}
