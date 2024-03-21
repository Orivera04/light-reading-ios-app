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
        
    func tokenValid() -> Bool {
        if let expDate = self.payloadDecoded["exp"] as? Int {
            let currentDate = Date()
            let tokenDate = Date(timeIntervalSince1970: TimeInterval(expDate))
            
            return currentDate <= tokenDate
        }
        
        return false
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
        if let jwToken = self.authToken {
            let tokenParts = jwToken.components(separatedBy: ".")
            let payload = tokenParts[1]
            let cleanedToken = payload.trimmingCharacters(in: .whitespacesAndNewlines)
            let paddedToken = cleanedToken.padding(toLength: ((cleanedToken.count + 3) / 4) * 4, withPad: "=", startingAt: 0)
            
            return paddedToken
        } else {
            print("Error: The JWT don't exist")
            
            return ""
        }
    }
}
