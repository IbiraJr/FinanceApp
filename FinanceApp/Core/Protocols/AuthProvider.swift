//
//  UserProvider.swift
//  FinanceApp
//
//  Created by Ibira Junior on 06/06/25.
//

import Combine

protocol AuthProvider {
    var currentUserId: String? { get }
    var currentUserPublisher: AnyPublisher<UserModel?, Never> { get }

    func register(email: String, password: String) -> AnyPublisher<Void, Error>
    func login(email: String, password: String) -> AnyPublisher<Void, Error>
    func logout() -> AnyPublisher<Void, Error>
}
