//
//  AuthRepository.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 28-07-22.
//

import Foundation

final class AuthRepository {
    
    private let authDatasource: AuthDatasource
    
    init(authDatasource: AuthDatasource = AuthDatasource()) {
        self.authDatasource = authDatasource
    }
    
    func createNewUser(email: String, password: String, completionBlock: @escaping (Result<UserModel, Error>) -> Void) {
        authDatasource.createNewUser(email: email, password: password, completionBlock: completionBlock)
    }

}

