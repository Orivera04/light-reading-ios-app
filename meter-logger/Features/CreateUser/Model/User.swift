//
//  User.swift
//  MeterLogger
//
//  Created by Kender Esteban Mendoza on 26/2/24.
//

import Foundation

struct User: Codable {
    var id: String
    var name: String
    var email: String
    var password: String

    init(
        id: String = "",
        name: String = "",
        email: String = "",
        password: String = ""
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.password = password
    }

    var isValid: Bool {
        return !(name.isEmpty && password.isEmpty && email.isEmpty)
    }
}
