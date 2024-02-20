//
//  ServeResponse.swift
//  light-reading-meter
//
//  Created by Oscar Rivera Moreira on 18/2/24.
//

import Foundation

struct ServeResponse: Codable {
    var message: String
    var translationKey: String
    var ok: Bool
}
