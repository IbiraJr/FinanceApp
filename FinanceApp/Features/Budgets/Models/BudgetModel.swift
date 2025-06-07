//
//  BudgetModel.swift
//  FinanceApp
//
//  Created by Ibira Junior on 03/06/25.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreCombineSwift

struct BudgetModel:  Identifiable, Codable {
    @DocumentID var id: String?
    var userId: String
    var title: String
    var totalValue: Double
    var createdAt: Date
}
