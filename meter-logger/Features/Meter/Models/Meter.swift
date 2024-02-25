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
    let currentReading: Int
    var desiredKwhMonthly: Int
    var lastReading: Int
    var lastInvoice: Date?
    var readings: [Reading]?

    // Constructor
    init(id: String = "",
         name: String = "",
         tag: String = "",
         desiredKwhMonthly: Int = 150,
         currentReading: Int = 0,
         lastInvoice: Date = Date(),
         lastReading: Int = 0,
         readings: [Reading] = []) {
        self.id = id
        self.name = name
        self.tag = tag
        self.desiredKwhMonthly = desiredKwhMonthly
        self.currentReading = currentReading
        self.lastReading = lastReading
        self.lastInvoice = lastInvoice
        self.readings = readings
    }

    // Decorators
    var currentReadingString: String {
        return "\(Int(currentReading)) " + NSLocalizedString("KWH", comment: "")
    }

    var lastReadingString: String {
        return "\(Int(lastReading )) " + NSLocalizedString("KWH", comment: "")
    }

    var lastInvoiceString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let lastInvoice = lastInvoice {
            return dateFormatter.string(from: lastInvoice)
        } else {
            return NSLocalizedString("not_available", comment: "")
        }
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
