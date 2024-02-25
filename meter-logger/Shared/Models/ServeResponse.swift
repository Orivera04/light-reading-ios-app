//
//  ServeResponse.swift
//  meter-logger
//
//  Created by Oscar Rivera Moreira on 18/2/24.
//

import Foundation

struct ServeResponse: Codable {
    var message: String?
    var error: String?
    var translationKey: String
    var ok: Bool
}
