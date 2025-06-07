//
//  FirebaseService.swift
//  FinanceApp
//
//  Created by Ibira Junior on 06/06/25.
//


import FirebaseAuth
import Combine

class FirebaseService:  AuthProvider {
    private let auth = Auth.auth()
    private let userSubject = CurrentValueSubject<UserModel?, Never>(nil)
    
    var currentUserId: String? {
        auth.currentUser?.uid
    }
    
    var currentUserPublisher: AnyPublisher<UserModel?, Never> {
        userSubject.eraseToAnyPublisher()
    }
    
    init() {
        _ = auth.addStateDidChangeListener { [weak self] _, user in
            if  user != nil {
                let userModel = UserModel(id: user!.uid, email: user?.email ?? "", name: user?.displayName ?? "")
                self?.userSubject.send(userModel)
            }else{
                self?.userSubject.send(nil)
            }
        }
    }
    
    func register(email: String, password: String) -> AnyPublisher<Void,  Error> {
        Future<Void, Error> { promise in
            self.auth.createUser(withEmail: email, password: password) { _, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
            
        }.eraseToAnyPublisher()
    }
    
    func login(email: String, password: String) -> AnyPublisher<Void,Error> {
        Future<Void,Error> { promise in
            self.auth.signIn(withEmail: email, password: password) { _, error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
            
        }.eraseToAnyPublisher()
    }
    
    func logout() -> AnyPublisher<Void, Error> {
        Future<Void, Error> { promise in
            do{
                try self.auth.signOut()
                promise(.success(()))
            }catch {
                promise(.failure(error))
            }
        }.eraseToAnyPublisher()
    }
    
    
    
    
    
    
}
