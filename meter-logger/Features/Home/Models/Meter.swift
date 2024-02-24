//
//  Meter.swift
//  meter-logger
//
//  Created by Oscar Rivera Moreira on 14/2/24.
//

import Foundation

struct Meter: Identifiable, Codable {
    // Properties
    var id = UUID()
    var name: String
    var tag: String
    var lastBillingKwh: Int?
    var lastInvoice: Date?
    var currentReading: Int?
    var desiredKwhMonthly: Int
    var lastReadings: [Reading]?

    // Constructor
    init(name: String = "",
         tag: String = "",
         lastBillingKwh: Int? = nil,
         lastInvoice: Date? = nil,
         currentReading: Int? = nil,
         desiredMonthlyKWH: Int = 150,
         lastReadings: [Reading]? = nil) {

        self.name = name
        self.tag = tag
        self.lastBillingKwh = lastBillingKwh
        self.lastInvoice = lastInvoice
        self.currentReading = currentReading
        self.desiredKwhMonthly = desiredMonthlyKWH
        self.lastReadings = lastReadings
    }

    // Decorators
    var currentReadingString: String {
        return "\(Int(currentReading ?? 0)) KWH"
    }

    var lastBillingKwhString: String {
        return "\(Int(lastBillingKwh ?? 0)) KWH"
    }

    var lastInvoiceString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        if let lastInvoice = lastInvoice {
            return dateFormatter.string(from: lastInvoice)
        } else {
            return ""
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
