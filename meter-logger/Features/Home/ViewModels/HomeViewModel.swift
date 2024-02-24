//
//  HomeViewModel.swift
//  meter-logger
//
//  Created by Oscar Rivera Moreira on 14/2/24.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var myMeters: [MeterHome] = []
    @Published var showErrorAlert = false
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false

    init() {
        self.isLoading = true

        fetchMeters()
    }

    func fetchMeters() {
        MeterService.shared.getMeters { [weak self] success, meterLists, error in
            DispatchQueue.main.async {
                self?.isLoading = false

                if success {
                    self?.myMeters = meterLists.meters
                } else {
                    print("Error: \(error ?? "Unknown error")")

                    self?.showErrorAlert = true
                    self?.errorMessage = NSLocalizedString(error ?? "something_went_wrong", comment: "")
                }
            }
        }
    }
}
