//
//  LoginViewModel.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 26-07-22.
//

import Foundation
import SwiftUI

final class LoginViewModel: ObservableObject {
    
    @Published var userModel: UserModel?
    @Published var emailValidationMessage: String = ""
    @Published var passwordValidationMessage: String = ""
    @Published var firebaseAuthErrorMessage: String = ""
    @Published var isSignupButtonSelected: Bool = false
    @Published var itWasAccountCreated: Bool = false
    
    private let authRepository: AuthRepository
    
    private let loginMessageError: [String] = [
        "El correo no puede estar vacío",
        "El correo no contiene el formato correcto",
    ]
    
    
    init(authRepository: AuthRepository = AuthRepository()) {
        self.authRepository = authRepository
    }
    
    /// This method validates email's format.
    /// The email can not be empty
    /// - Returns: Bool. True if all is correct. False if one of the validations can not be passed.
    func validateEmail(userEmail: String) -> Bool {
        if userEmail.isEmpty {
            self.emailValidationMessage = loginMessageError[0]
            print(self.emailValidationMessage)
            return false
        }
        
        if !userEmail.contains("@") || !userEmail.contains(".") {
            self.emailValidationMessage = loginMessageError[1]
            print(emailValidationMessage)
            return false
        }
        
        return true
    }
    
    /// This method validates password's rules.
    /// The methods checks if the password match with the regular expresion.
    /// Also, checks if the password is empty.
    /// And counts the characters must be more than 6.
    /// - Returns: True if all the validations can be completed successfuly. Else, return false
    func validatePassword(password: String) -> Bool {
        let pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[.$@$#!%*?&])"
        
        if password.isEmpty {
            self.passwordValidationMessage = "El campo de la contraseña no puede estar vacío \n"
            print(self.passwordValidationMessage)
            return false
        }
        
        if !(password.range(of: pattern, options: .regularExpression) != nil) {
            self.passwordValidationMessage = "La contraseña debe tener al menos una minúscula, una mayúscula, un caracter especial(.$@$#!%*?&). \n"
            print(self.passwordValidationMessage)
            return false
        }
        
        if password.count < 6 {
            self.passwordValidationMessage = "La contraseña debe tener como mínimo 6 caracteres. \n"
            print(self.passwordValidationMessage)
            return false
        }
        
        return true
    }
    
    
    /// This method creates a new user on firebase following the validateEmail method, the validatePassword method, and cheks if the password matches with the confirmPassword field. 
    /// - Returns: Void
    func createNewUser(email: String, password: String, confirmPassword: String) {
        if validateEmail(userEmail: email) && validatePassword(password: password) && password == confirmPassword {
            authRepository.createNewUser(email: email, password: password) { [weak self] result in
                switch result {
                case .success(let user):
                    self?.userModel = user
                    print("Success")
                case .failure(let error):
                    self?.firebaseAuthErrorMessage = error.localizedDescription
                    print(self?.firebaseAuthErrorMessage ?? "")
                }
                print(self?.itWasAccountCreated ?? false)
            }
            
            self.itWasAccountCreated = true
        }
        
        
        
    }
    
    
    
}
