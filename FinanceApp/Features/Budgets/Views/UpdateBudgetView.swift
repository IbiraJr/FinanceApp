//
//  UpdateBudgetView.swift
//  FinanceApp
//
//  Created by Ibira Junior on 07/06/25.
//

import SwiftUI

struct UpdateBudgetView: View {
    @State var budget: BudgetModel
    
    var body: some View {
        Form {
            
        }
    }
}

#Preview {
    UpdateBudgetView(budget: BudgetModel(userId: "123", title: "Meu Budget", totalValue: 10.0, createdAt: Date()))
}
