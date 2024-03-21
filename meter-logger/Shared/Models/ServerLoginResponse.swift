//
//  ServerLoginResponse.swift
//  MeterLogger
//
//  Created by Kender Esteban Mendoza on 1/3/24.
//

import Foundation

struct ServerLoginResponse: Codable {
    var message: String?
    var error: String?
    var translationKey: String
    var ok: Bool
    var uid: String
    var name: String
    var token: String
}
