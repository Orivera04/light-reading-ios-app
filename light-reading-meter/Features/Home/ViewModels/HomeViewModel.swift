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
    @Published var isLoading: Bool = false
    
    init() {
        self.isLoading = true
        
        fetchMeters()
    }
    
    func fetchMeters() {
        MeterService.shared.getMeters { [weak self] success, meters, error in
            DispatchQueue.main.async {
                sleep(1)
                self?.isLoading = false
                
                if success {
                    self?.myMeters = meters
                } else {
                    print("Error: \(error ?? "Unknown error")")
                    
                    self?.showErrorAlert = true
                    self?.errorMessage = NSLocalizedString("something_went_wrong", comment: "")
                }
            }
        }
    }
}
