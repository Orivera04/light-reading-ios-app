//
//  MeterViewModel.swift
//  meter-logger
//
//  Created by Oscar Rivera Moreira on 16/2/24.
//

import Foundation

class MeterViewModel: ObservableObject {
    @Published var meter: Meter
    @Published var showMessage: Bool = false
    @Published var messageTitle: String = ""
    @Published var messageBody: String = ""
    @Published var isLoading: Bool = false
    @Published var isSucessDeleted: Bool = false

    init(id: String) {
        self.meter = Meter()

        fetchMeter(id: id)
    }

    func fetchMeter(id: String) {
        self.isLoading = true

        MeterService.shared.getMeterById(id: id) { [weak self] success, meter, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if success {
                    self?.meter = meter!
                } else {
                    print("Error: \(error ?? "Unknown error")")
                    self?.showMessage(isSuccessMessage: false, body: error ?? "")
                }
            }
        }
    }


    func deleteMeter(id: String) {
        self.isLoading = true

        MeterService.shared.deleteMeterById(id: id) { [weak self] success, message in
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.showMessage(isSuccessMessage: success, body: message ?? "")

                if !success {
                    print("Error: \(message ?? "Unknown error")")
                }
            }
        }
    }

    func showMessage(isSuccessMessage: Bool, body: String) {
        self.messageTitle = isSuccessMessage ? NSLocalizedString("success", comment: "") : NSLocalizedString("error", comment: "")
        self.messageBody = body
        self.showMessage = true
    }
}
