//
//  MeterViewModel.swift
//  light-reading-meter
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
    
    init(id: UUID) {
        self.isLoading = true
        self.meter = Meter(name: "", tag: "", lastBillingPeriod: nil, lastInvoice: nil, currentReading: nil, desiredMonthlyKWH: 0, lastReadings: nil)

        fetchMeter(id: id)
    }
    
    func fetchMeter(id: UUID)  {
        MeterService.shared.getMeterById(id: id) { [weak self] success, meter, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                if success {
                    self?.meter = meter!
                } else {
                    print("Error: \(error ?? "Unknown error")")
                    
                    self?.showMessage = true
                    self?.messageTitle = NSLocalizedString("error", comment: "")
                    self?.messageBody = NSLocalizedString("something_went_wrong", comment: "")
                }
            }
        }
    }
    
    
    func deleteMeter(id: UUID) {
        MeterService.shared.deleteMeterById(id: id) { [weak self] success, error in
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.isSucessDeleted = success
                self?.showMessage = true
                
                if success {
                    self?.messageTitle = NSLocalizedString("success", comment: "")
                    self?.messageBody = NSLocalizedString("meter_deleted", comment: "")
                }
                else {
                    self?.messageTitle = NSLocalizedString("error", comment: "")
                    self?.messageBody = NSLocalizedString("something_went_wrong", comment: "")
                }
            }
        }
    }
}
