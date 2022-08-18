//
//  AuthDatasource.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 28-07-22.
//

import Foundation
import FirebaseAuth

final class AuthDatasource {
    
    func createNewUser(email: String, password: String, completionBlock: @escaping (Result<UserModel, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authDataResult, error in
            
            if let error = error {
                print("Error creating new user \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            
            let email = authDataResult?.user.email ?? "No email"
            print("New user creted with info \(email)")
            completionBlock(.success(.init(userEmail: email)))
        }
    }
    
    
    func login(email: String, password: String, completionBlock: @escaping(Result<UserModel, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authDataResult, error in
            if let error = error {
                print("Login error: \(error.localizedDescription)")
                completionBlock(.failure(error))
                return
            }
            
            if let email = authDataResult?.user.email {
                completionBlock(.success(.init(userEmail: email)))
            }
        }
    }
    
    
    func getCurrentUser() -> UserModel? {
        guard let email = Auth.auth().currentUser?.email else {
            return nil
        }
        
        return .init(userEmail: email)
    }
    
}
