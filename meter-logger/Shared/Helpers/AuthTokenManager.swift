//
//  AuthTokenManager.swift
//  MeterLogger
//
//  Created by Kender Esteban Mendoza on 5/3/24.
//

import Foundation

class AuthTokenManager {
    static let shared = AuthTokenManager()
    private var authToken: String?
    private var payloadDecoded: [String: Any] = [:]
    private var userName: String = ""
    
    private init() {}
    
    func setToken(token: String) {
        self.authToken = token
        self.setPayloadDecoded()
    }
    
    func getToken() -> String? {
        return self.authToken
    }
    
    func clearToken() {
        self.authToken = nil
    }
    
    func getPayloadDecoded() -> [String: Any] {
        return self.payloadDecoded
    }
    
    func getUserName() -> String {
        return self.userName
    }
        
    func tokenValid() -> Bool {
        guard let expDate = self.payloadDecoded["exp"] as? Int else { return false }
        
        let currentDate = Date()
        let tokenDate = Date(timeIntervalSince1970: TimeInterval(expDate))
        self.setUserName()
        
        return currentDate <= tokenDate

    }
    
    private func setUserName() {
        guard let name = self.payloadDecoded["name"] as? String else { return }
        
        self.userName = name
    }
    
    private func setPayloadDecoded() {
        self.payloadDecoded = self.decodingPayloadToken()
    }
            
    private func decodingPayloadToken() -> [String: Any] {
        let jwtPayload = self.cleanPayloadToken()
        
        guard let payloadData = Data(base64Encoded: jwtPayload, options: .ignoreUnknownCharacters),
              let payloadJson = try? JSONSerialization.jsonObject(with: payloadData, options: []) as? [String: Any]
        else {
            print("Error: Invalid JWT format")
            
            return [:]
        }
        
        return payloadJson
    }
    
    private func cleanPayloadToken() -> String {
        guard let jwToken = self.authToken else { return "" }
        let tokenParts = jwToken.components(separatedBy: ".")
        guard tokenParts.count > 2 else { return "" }
        
        let payload = tokenParts[1]
        let cleanedToken = payload.trimmingCharacters(in: .whitespacesAndNewlines)
        let paddedToken = cleanedToken.padding(toLength: ((cleanedToken.count + 3) / 4) * 4, withPad: "=", startingAt: 0)
        
        return paddedToken
        
    }
}
