//
//  LoginViewModel.swift
//  Happy Donuts
//
//  Created by Jacob Aguilar on 26-07-22.
//

import Foundation

final class LoginViewModel: ObservableObject {
    @Published var loginModel: LoginModel?
    @Published var emailValidationMessage: String = ""
    @Published var isSignupButtonSelected: Bool = false
    
    private let loginMessageError: [String] = [
        "El correo no puede estar vacío",
        "El correo no contiene el formato correcto",
    ]
    
    init() {
        
    }
    
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
    
    
    
}
