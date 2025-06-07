//
//  UserModel.swift
//  FinanceApp
//
//  Created by Ibira Junior on 06/06/25.
//

import Foundation

struct UserModel: Identifiable {
    var id: String
    var email: String
    var name: String?

    init(id: String, email: String, name: String? = nil) {
        self.id = id
        self.email = email
        self.name = name
    }
    
}
