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

    init() {
        self.reading = Reading(kWhReading: 0, dateOfReading: Date(), isLastCicle: false)
    }
    
    init(reading: Reading) {
        self.reading = reading
    }
    
    func manageReading() {
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
}
