//
//  Meter.swift
//  light-reading-meter
//
//  Created by Oscar Rivera Moreira on 14/2/24.
//

import Foundation

struct Meter: Identifiable, Codable {
    var id = UUID()
    var name: String
    var kWh: Int
    var tag: String
    var desiredMonthlyKWH: Int
    
    var kilowattHours: String {
        return "\(Int(kWh)) KWH"
    }
    
    var isValid: Bool {
        return !name.isEmpty && !tag.isEmpty && desiredMonthlyKWH > 0
    }
}
