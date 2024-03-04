//
//  AuthViewModel.swift
//  MeterLogger
//
//  Created by Kender Esteban Mendoza on 29/2/24.
//

import Foundation

//@MainActor
class AuthViewModel: ObservableObject {
    // @Published var token_valid: Bool
    @Published var tokenValid: Bool
    @Published var token: String
    @Published var user: User
    @Published var showMessage: Bool = false
    @Published var messageTitle: String = ""
    @Published var messageBody: String = ""
    @Published var isLoading: Bool = false
    @Published var isSuccess: Bool = false
    
    init() {
        // TODO:
        // add token in globar variable
        // * create user session
        // decoding token
        // * agregar token en la cabezera de cada petición

        self.user = User()
        self.token = ""
        self.tokenValid = false
    }
    
    func login() {
        UserService.shared.login(user: self.user) { success, message, response in
            DispatchQueue.main.async {
                self.isLoading = false
                self.isSuccess = success
                
                if success {

                    
                    if let jwt = response?.token {
                        self.token = jwt
                        let payloadData = self.decoding_token(jwtToken: jwt)
                        if let expirationDate = payloadData["exp"] as? Int {
                            self.tokenValid = self.tokenValid(tokenExp: expirationDate)
                        }
                    }
                } else {
                    print("Error: \(message ?? "Unknown error")")
                }
            }
        }
    }
    
    func tokenValid(tokenExp: Int) -> Bool {
        let currentDate = Date()
        let tokenDate = Date(timeIntervalSince1970: TimeInterval(tokenExp))
        
        return currentDate <= tokenDate
    }
    
    func decoding_token(jwtToken: String) -> [String: Any] {
        let tokenParts = jwtToken.components(separatedBy: ".")
        guard tokenParts.count >= 2,
              let payloadData = Data(base64Encoded: tokenParts[1]),
              let payloadJson = try? JSONSerialization.jsonObject(with: payloadData, options: []) as? [String: Any] else {
            
            print("Invalid JWT token format")
            return [:]
        }
        
        return payloadJson
    }
    

    func showMessage(isSuccessMessage: Bool, body: String) {
        self.messageTitle = isSuccessMessage ? NSLocalizedString("success", comment: "") : NSLocalizedString("error", comment: "")
        self.messageBody = body
        self.showMessage = true
    }
}
