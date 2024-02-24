//
//  ListMeterHome.swift
//  MeterLogger
//
//  Created by Oscar Rivera Moreira on 23/2/24.
//

import Foundation

struct ListMeterHome: Codable {
    let meters: [MeterHome]

    init() {
        self.meters = []
    }
}
