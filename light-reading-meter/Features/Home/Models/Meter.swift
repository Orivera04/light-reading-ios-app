//
//  Meter.swift
//  light-reading-meter
//
//  Created by Oscar Rivera Moreira on 14/2/24.
//

import Foundation

struct Meter: Identifiable, Codable {
    // Properties
    var id = UUID()
    var name: String
    var kWh: Int
    var tag: String
    var desiredMonthlyKWH: Int
    
    // Decorators
    var kilowattHours: String {
        return "\(Int(kWh)) KWH"
    }
    
    // Validations
    var isValid: Bool {
        return !name.isEmpty && !tag.isEmpty && desiredMonthlyKWH > 0
    }
    
    var errors: [String] {
        var errorMessages: [String] = []
       
        if name.isEmpty {
            errorMessages.append(NSLocalizedString("name_is_empty", comment: ""))
        }
       
        if tag.isEmpty {
            errorMessages.append(NSLocalizedString("tag_is_empty", comment: ""))
        }
       
        return errorMessages
    }
       
    var showModelErrors: String {
        return errors.joined(separator: "\n")
    }
}
