//
//  MeterInformation.swift
//  MeterLogger
//
//  Created by Oscar Rivera Moreira on 24/2/24.
//

import Foundation

struct MeterInformation: Codable {
    let meter: MeterDetail

    init() {
        self.meter = MeterDetail()
    }
    
}
