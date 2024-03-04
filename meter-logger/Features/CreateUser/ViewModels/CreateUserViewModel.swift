//
//  CreateUserViewModel.swift
//  MeterLogger
//
//  Created by Kender Esteban Mendoza on 26/2/24.
//

import Foundation

class CreateUserViewModel: ObservableObject {
    @Published var user: User
    @Published var showMessage: Bool = false
    @Published var messageTitle: String = ""
    @Published var messageBody: String = ""
    @Published var isLoading: Bool = false
    @Published var isSuccess: Bool = false
    
    init() {
        self.user = User()
    }
    
    func createUser() {
        guard user.isValid else { print("User isn't valid"); return }
        
        self.isLoading = true
        
        UserService.shared.saveUser(user: self.user) { success, message in
            DispatchQueue.main.async {
                self.isLoading = false
                self.isSuccess = success
                
                self.showMessage(isSuccessMessage: success, body: message ?? "")
                
                if !success { print("Error: \(message ?? "Unknown error")") }
            }
        }
    }
    
    func showMessage(isSuccessMessage: Bool, body: String) {
        self.messageTitle = isSuccessMessage ? NSLocalizedString("success", comment: "") : NSLocalizedString("error", comment: "")
        self.messageBody = body
        self.showMessage = true
    }
}
