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
}
