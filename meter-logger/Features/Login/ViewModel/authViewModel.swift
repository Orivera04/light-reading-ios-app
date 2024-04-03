//
//  AuthViewModel.swift
//  MeterLogger
//
//  Created by Kender Esteban Mendoza on 29/2/24.
//

import Foundation

class AuthViewModel: ObservableObject {
    @Published var user: User
    @Published var userHasSession: Bool = false
    @Published var showMessage: Bool = false
    @Published var messageTitle: String = ""
    @Published var messageBody: String = ""
    @Published var isLoading: Bool = false
    @Published var isSuccess: Bool = false

    init() {
        self.user = User()

        if let jwt = UserDefaults.standard.string(forKey: "x-token") {
            AuthTokenManager.shared.setToken(token: jwt)
            self.userHasSession = AuthTokenManager.shared.tokenValid()
            self.buildUserInstance()
            if self.isTokenExpiringSoon() { self.refreshToken() }
        }
    }

    func login() {
        guard formIsValid else { return }

        UserService.shared.login(user: self.user) { success, message, response in
            DispatchQueue.main.async {
                self.isLoading = false
                self.isSuccess = success

                if success {
                    if let jwt = response?.token {
                        AuthTokenManager.shared.setToken(token: jwt)
                        UserDefaults.standard.set(jwt, forKey: "x-token")
                        self.userHasSession = AuthTokenManager.shared.tokenValid()
                        self.user.name = AuthTokenManager.shared.getUserName()
                        UserDefaults.standard.set(self.user.info, forKey: "user-info")
                    }
                } else {
                    print("Error: \(message ?? "Unknown error")")
                }
            }
        }
    }

    func logOut() {
        AuthTokenManager.shared.setToken(token: "")
        UserDefaults.standard.set("", forKey: "x-token")
        UserDefaults.standard.set(["":""], forKey: "user-info")
        self.userHasSession = AuthTokenManager.shared.tokenValid()
        self.user = User()
    }

    func showMessage(isSuccessMessage: Bool, body: String) {
        self.messageTitle = isSuccessMessage ? NSLocalizedString("success", comment: "") : NSLocalizedString("error", comment: "")
        self.messageBody = body
        self.showMessage = true
    }

    private func refreshToken() {
        UserService.shared.refreshToken() { success, message, response in
            DispatchQueue.main.async {
                self.isLoading = false
                self.isSuccess = success

                if success {
                    if let jwt = response?.token {
                        AuthTokenManager.shared.setToken(token: jwt)
                        UserDefaults.standard.set(jwt, forKey: "x-token")
                        self.userHasSession = AuthTokenManager.shared.tokenValid()
                    }
                } else {
                    print("Error: \(message ?? "Unknown error")")
                }
            }
        }
    }

    private func buildUserInstance() {
        guard let userInfo = UserDefaults.standard.dictionary(forKey: "user-info") else { return }
        guard let name = userInfo["name"] as? String, let email = userInfo["email"] as? String else { return }

        self.user = User(name: name, email: email)
    }

    private func isTokenExpiringSoon() -> Bool {
        let tokenPayload = AuthTokenManager.shared.getPayloadDecoded()
        guard let tokenPayloadExpiration = tokenPayload["exp"] else { return false }

        if let expirationTime = tokenPayloadExpiration as? Int {
            let currentDate = Date()
            let expirationDate = Date(timeIntervalSince1970: TimeInterval(expirationTime))

            guard currentDate <= expirationDate else { return false }

            let timeIntervalUntilExpiration = expirationDate.timeIntervalSince(currentDate)
            let twoDaysInSeconds: TimeInterval = (2 * 24 * 60 * 60)

            return timeIntervalUntilExpiration <= twoDaysInSeconds ? true : false
        } else {
            return false
        }
    }
}

extension AuthViewModel: FormProtocol {
    var formIsValid: Bool {
        return user.email.count > 7 &&
            user.email.contains("@") &&
            user.password.count > 8
    }
}
