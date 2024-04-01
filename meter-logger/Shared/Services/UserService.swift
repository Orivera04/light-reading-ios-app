//
//  UserService.swift
//  MeterLogger
//
//  Created by Kender Esteban Mendoza on 1/3/24.
//

import Foundation

class UserService {
    private let apiClient = APIClient.shared
    static let shared = UserService()
    
    func login(user: User, completion: @escaping (Bool, String, ServerLoginResponse?) -> ()) {
        let deserializedUser: [String: String] = [
            "email": user.email,
            "password": user.password
        ]
        
        apiClient.call(
            endpoint: "auth/",
            method: .POST,
            params: deserializedUser,
            httpHeader: .application_json
        ) { success, data in
            guard let data = data else { completion(false, "Error: User Post request failed", nil); return }
                
            do {
                let response = try JSONDecoder().decode(ServerLoginResponse.self, from: data)
                
                completion(response.ok, NSLocalizedString(response.translationKey, comment: ""), response)
            } catch {
                completion(false, "Error: Parsing User failed", nil)
            }
        }
    }
    
    func refreshToken(completion: @escaping (Bool, String, ServerLoginResponse?) -> ()) {
        apiClient.call(
            endpoint: "auth/renew",
            method: .GET,
            params: nil,
            httpHeader: .none
        ) { success, data in
            guard success, let data = data else { completion(false, "Error: User Post request failed", nil); return }
            
            do {
                let response = try JSONDecoder().decode(ServerLoginResponse.self, from: data)
                
                completion(response.ok, NSLocalizedString(response.translationKey, comment: ""), response)
            } catch {
                completion(false, "Error: Parsing User failed", nil)
            }
        }
    }
    
    func saveUser(user: User, completion: @escaping (Bool, String?) -> ()) {
        // TODO: Create method on model
        let deserializedUser: [String: String] = [
            "name": user.name,
            "email": user.email,
            "password": user.password
        ]
        
        apiClient.call(
            endpoint: "auth/new",
            method: .POST,
            params: deserializedUser,
            httpHeader: .application_json
        ) { success, data in
            guard success, let data = data else { completion(false, "Error: User Post request failed"); return }
            
            do {
                let response = try JSONDecoder().decode(ServeResponse.self, from: data)
                print(response)
                
                completion(response.ok, NSLocalizedString(response.translationKey, comment: ""))
            } catch {
                completion(false, "Error: Parsing User failed")
            }
        }
    }
}
