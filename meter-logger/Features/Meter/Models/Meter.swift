//
//  Meter.swift
//  meter-logger
//
//  Created by Oscar Rivera Moreira on 14/2/24.
//

import Foundation

struct Meter: Codable {
    // Properties
    var id: String
    var name: String
    var tag: String
    var desiredKwhMonthly: Int

    // Constructor
    init(id: String = "",
         name: String = "",
         tag: String = "",
         desiredKwhMonthly: Int = 150) {
        self.id = id
        self.name = name
        self.tag = tag
        self.desiredKwhMonthly = desiredKwhMonthly
    }


    // Validations
    var isValid: Bool {
        return !name.isEmpty && !tag.isEmpty && desiredKwhMonthly > 0
    }

    var errors: [String] {
        var errorMessages: [String] = []

        if name.isEmpty {
            errorMessages.append(NSLocalizedString("name_is_empty", comment: ""))
        }

        if tag.isEmpty {
            errorMessages.append(NSLocalizedString("tag_is_empty", comment: ""))
        }

        if desiredKwhMonthly <= 0 {
            errorMessages.append(NSLocalizedString("invalid_desired_kwh_monthly", comment: ""))
        }

        return errorMessages
    }

    var showModelErrors: String {
        return errors.joined(separator: "\n")
    }
}
