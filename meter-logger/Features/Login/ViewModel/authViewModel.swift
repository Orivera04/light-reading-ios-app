//
//  AuthViewModel.swift
//  MeterLogger
//
//  Created by Kender Esteban Mendoza on 29/2/24.
//

import Foundation

//@MainActor
class AuthViewModel: ObservableObject {
    // session
    // singIn
    // logOut
    @Published var userSession: User?
    
    func login(email: String, password: String) {
        
        if let userSession = userSession {
            print("que verga?")
            self.userSession = User(name: "Kender", email: email, password: password)
        } else {
            print("the final")
            self.userSession = User(name: "Kender", email: email, password: password)
        }
        
        print("Loging testing ...")
        print(email)
        print(password)
        print("Testing ...")
    }
}
