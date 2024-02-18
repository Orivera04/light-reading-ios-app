//
//  ReadingViewModel.swift
//  light-reading-meter
//
//  Created by Oscar Rivera Moreira on 17/2/24.
//

import Foundation

class ManageReadingViewModel: ObservableObject {
    @Published var reading: Reading
    @Published var showMessage: Bool = false
    @Published var messageTitle: String = ""
    @Published var messageBody: String = ""
    @Published var isLoading: Bool = false
    @Published var isSuccess: Bool = false
    @Published var isSuccessDeleted: Bool = false

    // New Record
    init(meterId: UUID) {
        self.reading = Reading()
    }
    
    init(reading: Reading) {
        self.reading = reading
    }
    
    func manageReading(isNewRecord: Bool) {
        if isNewRecord {
            saveNewReading()
        }
        else {
            updateReading()
        }
    }
    
    func saveNewReading() {
        guard self.reading.isValid else {
            print("Invalid reading data")
            self.messageTitle = NSLocalizedString("error", comment: "")
            self.messageBody =  self.reading.showModelErrors
            self.showMessage = true

            return
        }

        self.isLoading = true

        ReadingService.shared.saveReading(reading: reading) { success, message in
            DispatchQueue.main.async {
                sleep(1)
                self.isLoading = false
                self.showMessage = true
                self.messageBody = message ?? ""

                self.messageTitle = success ? NSLocalizedString("success", comment: "") : NSLocalizedString("error", comment: "")
                self.isSuccess = success

                if !success {
                    print("Error: \(message ?? "Unknown error")")
                }
            }
       }
    }
    
    func updateReading() {
        guard self.reading.isValid else {
            print("Invalid reading data")
            self.messageTitle = NSLocalizedString("error", comment: "")
            self.messageBody =  self.reading.showModelErrors
            self.showMessage = true

            return
        }

        self.isLoading = true

        ReadingService.shared.updateReading(reading: reading) { success, message in
            DispatchQueue.main.async {
                sleep(1)
                self.isLoading = false
                self.showMessage = true
                self.messageBody = message ?? ""

                self.messageTitle = success ? NSLocalizedString("success", comment: "") : NSLocalizedString("error", comment: "")
                self.isSuccess = success

                if !success {
                    print("Error: \(message ?? "Unknown error")")
                }
            }
       }
    }

    func deleteMeter() {
        ReadingService.shared.deleteReading(id: self.reading.id) { [weak self] success, error in
            DispatchQueue.main.async {
                sleep(1)
                self?.isLoading = false
                self?.isSuccessDeleted = success
                self?.showMessage = true

                if success {
                    self?.messageTitle = NSLocalizedString("success", comment: "")
                    self?.messageBody = NSLocalizedString("reading_deleted", comment: "")
                }
                else {
                    self?.messageTitle = NSLocalizedString("error", comment: "")
                    self?.messageBody = NSLocalizedString("something_went_wrong", comment: "")
                }
            }
        }
    }
}
