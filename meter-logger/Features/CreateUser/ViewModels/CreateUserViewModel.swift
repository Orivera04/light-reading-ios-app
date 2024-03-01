//
//  CreateUserViewModel.swift
//  MeterLogger
//
//  Created by Kender Esteban Mendoza on 26/2/24.
//

import Foundation

class CreateUserViewModel: ObservableObject {
    @Published var user: User
    
    init() {
        self.user = User()
    }
    
    init(user: User) {
        self.user = user
    }
    
    // Create
    func createUser(name: String, email: String, password: String) {
        guard user.isValid else {
            print("User isn't valid")
            return
        }
        
        
        print(name)
        print(email)
        print(password)
        print("Testing ...")
    }
    
    // Update
    // Delete
}
