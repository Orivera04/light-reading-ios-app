//
//  light_reading_meterApp.swift
//  meter-logger
//
//  Created by Oscar Rivera Moreira on 6/2/24.
//

import SwiftUI

@main
struct meter_loggerApp: App {
    @StateObject var authViewModel = AuthViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(authViewModel)
        }
    }
}
