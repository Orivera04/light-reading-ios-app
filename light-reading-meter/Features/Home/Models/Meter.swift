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
    var tag: String
    var lastBillingPeriod: Date?
    var lastInvoice: Date?
    var currentReading: Int?
    var desiredMonthlyKWH: Int
    var lastReadings: [Reading]?
    
    // Decorators
    var currentReadingString: String {
        return "\(Int(currentReading ?? 0)) KWH"
    }
    
    var lastBillingPeriodString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let lastBillingPeriod = lastBillingPeriod {
            return dateFormatter.string(from: lastBillingPeriod)
        } else {
            return ""
        }
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
