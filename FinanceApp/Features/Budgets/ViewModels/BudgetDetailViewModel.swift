//
//  BudgetDetailViewModel.swift
//  FinanceApp
//
//  Created by Ibira Junior on 09/06/25.
//

import Foundation
import Combine

class BudgetDetailViewModel: ObservableObject {
    @Published var budget: BudgetModel
    private let service = BudgetService()
    private let originalBudget: BudgetModel
    private var cancellables = Set<AnyCancellable>()
    
    init(budget: BudgetModel) {
        self.budget = budget
        self.originalBudget = budget
    }
    
    var hasChanges: Bool {
        budget.title != originalBudget.title ||
        budget.totalValue != originalBudget.totalValue
    }
    
    func update() {
        service.updateBudget(budget)
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
            .store(in: &cancellables)
    }
    
    func delete() {
        if let budgetId = budget.id {
            service.deleteBudget(budgetId)
                .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
                .store(in: &cancellables)
        }
        
    }
    
    
    
    
}
