//
//  ManageMeterViewModel.swift
//  light-reading-meter
//
//  Created by Oscar Rivera Moreira on 15/2/24.
//

import Foundation

class ManageMeterViewModel: ObservableObject {
    @Published var meter: Meter
    @Published var showMessage: Bool = false
    @Published var messageTitle: String = ""
    @Published var messageBody: String = ""
    @Published var isLoading: Bool = false
    @Published var isSuccess: Bool = false

    init() {
        self.meter = Meter()
    }

    init(meter: Meter) {
        self.meter = meter
    }

    func manageMeter(isNewRecord: Bool) {
        if isNewRecord {
            saveNewMeter()
        }
        else {
            updateNewMeter()
        }
    }


    func saveNewMeter() {
        guard self.meter.isValid else {
            print("Invalid meter data")
            showMessage(isSuccessMessage: false, body: self.meter.showModelErrors)

            return
        }

        self.isLoading = true

        MeterService.shared.saveMeter(meter: self.meter) { success, message in
            DispatchQueue.main.async {
                self.isLoading = false
                self.isSuccess = success

                self.showMessage(isSuccessMessage: success, body: message ?? "")
                if !success {
                    print("Error: \(message ?? "Unknown error")")
                }
           }
       }
    }

    func updateNewMeter() {
        guard self.meter.isValid else {
            print("Invalid meter data")
            showMessage(isSuccessMessage: false, body: self.meter.showModelErrors)

            return
        }

        self.isLoading = true

        MeterService.shared.updateMeter(meter: self.meter) { success, message in
            DispatchQueue.main.async {
                self.isLoading = false
                self.isSuccess = success

                self.showMessage(isSuccessMessage: success, body: message ?? "")
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
