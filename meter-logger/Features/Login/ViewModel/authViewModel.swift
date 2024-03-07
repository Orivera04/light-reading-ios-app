//
//  AuthViewModel.swift
//  MeterLogger
//
//  Created by Kender Esteban Mendoza on 29/2/24.
//

import Foundation

class AuthViewModel: ObservableObject {
    @Published var user: User
    @Published var userHaveSession: Bool = false
    @Published var showMessage: Bool = false
    @Published var messageTitle: String = ""
    @Published var messageBody: String = ""
    @Published var isLoading: Bool = false
    @Published var isSuccess: Bool = false

    init() {
        self.user = User()
        if let jwt = UserDefaults.standard.string(forKey: "x-token") {
            AuthTokenManager.shared.setToken(token: jwt)
            self.userHaveSession = AuthTokenManager.shared.tokenValid()

            if !self.userHaveSession { self.refreshToken() }
        }
    }

    func login() {
        UserService.shared.login(user: self.user) { success, message, response in
            DispatchQueue.main.async {
                self.isLoading = false
                self.isSuccess = success

                if success {
                    if let jwt = response?.token {
                        AuthTokenManager.shared.setToken(token: jwt)
                        UserDefaults.standard.set(jwt, forKey: "x-token")
                        self.userHaveSession = AuthTokenManager.shared.tokenValid()
                    }
                } else {
                    print("Error: \(message ?? "Unknown error")")
                }
            }
        }
    }

    func showMessage(isSuccessMessage: Bool, body: String) {
        self.messageTitle = isSuccessMessage ? NSLocalizedString("success", comment: "") : NSLocalizedString("error", comment: "")
        self.messageBody = body
        self.showMessage = true
    }

    private func refreshToken() {
        print("entro a refresh token")
        UserService.shared.refreshToken() { success, message, response in
            DispatchQueue.main.async {
                self.isLoading = false
                self.isSuccess = success

                if success {
                    if let jwt = response?.token {
                        AuthTokenManager.shared.setToken(token: jwt)
                        UserDefaults.standard.set(jwt, forKey: "x-token")
                        self.userHaveSession = AuthTokenManager.shared.tokenValid()
                    }
                } else {
                    print("Error: \(message ?? "Unknown error")")
                }
            }
        }
    }
}
