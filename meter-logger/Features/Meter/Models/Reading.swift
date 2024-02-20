//
//  Reading.swift
//  meter-logger
//
//  Created by Oscar Rivera Moreira on 16/2/24.
//

import Foundation

struct Reading: Identifiable, Codable {
    // Properties
    var id = UUID()
    var meterId: UUID
    var kWhReading: Int
    var accumulatedkWhReading: Int
    var dateOfReading: Date
    var isLastCycle: Bool

    // Constructor
    init(meterId: UUID = UUID(),
            kWhReading: Int = 0,
            accumulatedkWhReading: Int = 0,
            dateOfReading: Date = Date(),
            isLastCycle: Bool = false) {
       self.meterId = meterId
       self.kWhReading = kWhReading
       self.accumulatedkWhReading = accumulatedkWhReading
       self.dateOfReading = dateOfReading
       self.isLastCycle = isLastCycle
    }

    // Decorators
    var kilowatsReadingString: String {
        return "\(Int(kWhReading)) KWH"
    }

    var kilowatsAcumulatedReadingString: String {
        return "\(Int(accumulatedkWhReading)) KWH"
    }

    var dateOfReadingString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        return dateFormatter.string(from: dateOfReading)
    }

    // Validations

    var isValid: Bool {
        return kWhReading > 0
    }

    var errors: [String] {
        var errorMessages: [String] = []

        if kWhReading <= 0 {
            errorMessages.append(NSLocalizedString("kwh_is_not_valid", comment: ""))
        }


        return errorMessages
    }

    var showModelErrors: String {
        return errors.joined(separator: "\n")
    }

}
