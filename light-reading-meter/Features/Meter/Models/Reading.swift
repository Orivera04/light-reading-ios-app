//
//  Reading.swift
//  light-reading-meter
//
//  Created by Oscar Rivera Moreira on 16/2/24.
//

import Foundation

struct Reading: Identifiable, Codable {
    // Properties
    var id = UUID()
    var kWhReading: Int = 0
    var acumulatedkWhReading = 0
    var dateOfReading: Date
    var isLastCicle: Bool
    
    // Decorators
    var kilowatsReadingString: String {
        return "\(Int(kWhReading)) KWH"
    }
    
    var kilowatsAcumulatedReadingString: String {
        return "\(Int(acumulatedkWhReading)) KWH"
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
