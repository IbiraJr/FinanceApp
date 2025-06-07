//
//  AuthViewModel.swift
//  FinanceApp
//
//  Created by Ibira Junior on 03/06/25.
//

import Foundation
import FirebaseAuth
import Combine


class AuthViewModel : ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var error: String?
    @Published var isAuthenticated: Bool = false
    @Published var user: UserModel?
    
    private let firebaseService: AuthProvider
    private var cancellables = Set<AnyCancellable>()
    
    init(authService: AuthProvider) {
        self.firebaseService = authService
        authService.currentUserPublisher
            .receive(on: DispatchQueue.main)
            .sink {
                [weak self] user in
                self?.user = user
                self?.isAuthenticated = user != nil
            }
            .store(in: &cancellables)
    }
    
    func signIn() {
        error = nil
        firebaseService.login(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.error = error.localizedDescription
                }
            }, receiveValue: { })
            .store(in: &cancellables)
    }
    
    func signUp() {
        firebaseService.register(email: email, password: password)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.error = error.localizedDescription
                }
            }, receiveValue: { })
            .store(in: &cancellables)
        
        
    }
    
    func signOut() {
        firebaseService.logout()
            .sink(receiveCompletion: { _ in }, receiveValue: { })
            .store(in: &cancellables)
        
    }
}
