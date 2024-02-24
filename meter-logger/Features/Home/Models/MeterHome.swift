//
//  MeterHome.swift
//  MeterLogger
//
//  Created by Oscar Rivera Moreira on 23/2/24.
//

import Foundation

struct MeterHome: Identifiable, Codable {
    // Properties
    var id: String
    var name: String
    var tag: String
    var desiredKwhMonthly: Int
    var currentReading: Int
    
    // Decorators
    var currentReadingString: String {
        return "\(Int(currentReading)) KWH"
    }
}
