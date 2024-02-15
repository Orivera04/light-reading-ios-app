//
//  HomeViewModel.swift
//  light-reading-meter
//
//  Created by Oscar Rivera Moreira on 14/2/24.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var myMeters: [Meter] = []
    @Published var showErrorAlert = false
    @Published var errorMessage: String?
    
    init() {
        fetchMeters()
    }
    
    func fetchMeters() {
        MeterService.shared.getMeters { [weak self] success, meters, error in
            if success {
                DispatchQueue.main.async {
                    self?.myMeters = meters
                }
            } else {
                print("Error: \(error ?? "Unknown error")")
                
                DispatchQueue.main.async {
                    self?.showErrorAlert = true
                    self?.errorMessage = NSLocalizedString("something_went_wrong", comment: "")
                }
            }
        }
    }
}
