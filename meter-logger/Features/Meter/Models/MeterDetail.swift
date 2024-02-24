//
//  MeterDetails.swift
//  MeterLogger
//
//  Created by Oscar Rivera Moreira on 24/2/24.
//

import Foundation

struct MeterDetail: Codable {
    let id: String
    let name: String
    let currentReading: Int
    let lastReading: Int
    let lastInvoice: Date?
    let desiredKwhMonthly: Int
    let readings: [Reading]?

    init(id: String = "", name: String = "", currentReading: Int = 0, lastInvoice: Date = Date(), lastReading: Int = 0, readings: [Reading] = [], desiredKwhMonthly: Int = 0) {
        self.id = id
        self.name = name
        self.currentReading = currentReading
        self.lastInvoice = lastInvoice
        self.lastReading = lastReading
        self.readings = readings
        self.desiredKwhMonthly = desiredKwhMonthly
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
}
