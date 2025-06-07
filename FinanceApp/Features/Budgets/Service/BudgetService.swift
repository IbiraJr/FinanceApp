//
//  BudgetService.swift
//  FinanceApp
//
//  Created by Ibira Junior on 03/06/25.
//

import Foundation
import FirebaseFirestore
import Combine

protocol BudgetServiceProtocol {
    func fetchBudgets(for userId: String) -> AnyPublisher<[BudgetModel],Error>
    func createBudget(_ budget: BudgetModel) -> AnyPublisher<Void,Error>
    func deleteBudget(_ budgetId: String) -> AnyPublisher<Void,Error>
    func updateBudget(_ budget: BudgetModel) -> AnyPublisher<BudgetModel,Error>
    
}

struct BudgetService: BudgetServiceProtocol {
    
    private let db = Firestore.firestore()
    
    func fetchBudgets(for userId: String) -> AnyPublisher<[BudgetModel],Error> {
        let subject = PassthroughSubject<[BudgetModel],Error>()
        
        self.db.collection("budgets")
            .whereField("userId", isEqualTo: userId)
            .order(by: "createdAt", descending: true)
        
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    subject.send(completion: .failure(error))
                    
                } else if let documents = snapshot?.documents {
                    let budgets = documents.compactMap { doc -> BudgetModel? in
                        try? doc.data(as: BudgetModel.self)
                    }
                    
                    subject.send(budgets)
                }
            }
        
        return subject.eraseToAnyPublisher()
    }
    
    func createBudget(_ budget: BudgetModel) -> AnyPublisher<Void,Error> {
        Future<Void,Error> { promise in
            do {
                _ = try self.db.collection("budgets").addDocument(from: budget)
                
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func deleteBudget(_ budgetId: String) -> AnyPublisher<Void, Error> {
        Future<Void,Error> { promise in
            self.db.collection( "budgets" ).document( budgetId ).delete { error in
                if let error = error {
                    promise(.failure(error))
                } else{
                    promise(.success(()))
                }
                
            }
            
        }
        .eraseToAnyPublisher()
    }
    
    func updateBudget(_ budget: BudgetModel) -> AnyPublisher<BudgetModel, Error> {
        Future<BudgetModel, Error> { promise in
//            self.db.collection("budgets").document( budget.id ).updateData(budget)
                
        }
    }
    
}
