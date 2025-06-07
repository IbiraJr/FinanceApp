//
//  BudgetViewModel.swift
//  FinanceApp
//
//  Created by Ibira Junior on 03/06/25.
//

import Foundation
import Combine

class BudgetViewModel: ObservableObject {
    @Published var budgets: [BudgetModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var selectedBudget: BudgetModel?
    
    private var cancellables = Set<AnyCancellable>()
    private let service = BudgetService()
    private let userId: String
    
    
    init(userId: String) {
        self.userId = userId
        fetchBudgets()
    }
    
    func fetchBudgets() {
        isLoading = true
        
        service.fetchBudgets(for: userId)
            .receive(on: RunLoop.main)
            .sink { completion in
                self.isLoading = false
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { budgets in
                self.isLoading = false
                self.budgets = budgets
            }
            .store(in: &cancellables)
    }
    
    func createBudget(title: String, totalValue: Double) {
        let newBudget = BudgetModel(
            userId: userId,
            title: title,
            totalValue: totalValue,
            createdAt: Date()
        )
        service.createBudget(newBudget)
            .sink(
                receiveCompletion: { _ in},
                receiveValue: { [weak self] in self?.fetchBudgets() }
            )
            .store(in: &cancellables)
        
    }
    
    func deleteBudget(_ budget: BudgetModel) {
        if let budgetId = budget.id {
            service.deleteBudget(budgetId)
                .sink(
                    receiveCompletion: { _ in},
                    receiveValue: { [weak self] in self?.fetchBudgets() }
                )
                .store(in: &cancellables)
        }
        
    }
}
