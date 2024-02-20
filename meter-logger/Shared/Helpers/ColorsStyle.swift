//
//  Colors.swift
//  meter-logger
//
//  Created by Oscar Rivera Moreira on 18/2/24.
//

import Foundation
import SwiftUI

class ColorsStyle {
    static func colorForKWh(kWh: Int, threshold: Int) -> Color {
        let percentage = Double(kWh) / Double(threshold)

        if percentage <= Constants.RED_THRESHOLD_METER {
            return .green
        } else if percentage <= Constants.YELLOW_THRESHOLD_METER {
            return .yellow
        } else {
            return .red
        }
    }
}
