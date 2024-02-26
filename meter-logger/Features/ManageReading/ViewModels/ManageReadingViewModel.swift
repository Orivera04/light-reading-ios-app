//
//  ReadingViewModel.swift
//  meter-logger
//
//  Created by Oscar Rivera Moreira on 17/2/24.
//

import Foundation
import SwiftUI

class ManageReadingViewModel: ObservableObject {
    @Published var reading: Reading
    @Published var showMessage: Bool = false
    @Published var messageTitle: String = ""
    @Published var messageBody: String = ""
    @Published var isLoading: Bool = false
    @Published var isSuccess: Bool = false
    @Published var isSuccessDeleted: Bool = false
    @Published var selectedImage: UIImage?

    // New Record
    init(meterId: String, currentReading: Int) {
        self.reading = Reading(meterId: meterId, kWhReading: currentReading)
    }

    // Previous Record
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
        guard reading.isValid else {
            print("Invalid reading data")
            showMessage(isSuccessMessage: false, body: reading.showModelErrors)

            return
        }

        self.isLoading = true

        ReadingService.shared.saveReading(reading: reading) { success, message in
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

    func updateReading() {
        guard self.reading.isValid else {
            print("Invalid reading data")
            self.showMessage(isSuccessMessage: false, body: self.reading.showModelErrors)

            return
        }

        self.isLoading = true

        ReadingService.shared.updateReading(reading: reading) { success, message in
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

    func deleteMeter() {
        ReadingService.shared.deleteReading(id: self.reading.id) { [weak self] success, message in
            DispatchQueue.main.async {
                self?.isLoading = false
                self?.isSuccessDeleted = success

                self?.showMessage(isSuccessMessage: success, body: message ?? "")

                if !success {
                    print("Error: \(message ?? "Unknown error")")
                }
            }
        }
    }
    
    func processImage() {
        guard let selectedImage = selectedImage else {
            self.showMessage(isSuccessMessage: false, body: NSLocalizedString("no_image_supplied", comment: ""))
            fatalError("No image supplied selectedImage is nil.")
        }

        self.isLoading = true

        recognizeText(in: selectedImage) { detectedText, success in
            self.isLoading = false

            if success {
                self.processDetectedText(detectedText)
            } else {
                self.showMessage(isSuccessMessage: false, body: NSLocalizedString("text_recognition_failed", comment: ""))
                print("Text recognition failed")
            }
        }
    }

    private func recognizeText(in image: UIImage, completion: @escaping (String?, Bool) -> Void) {
        let imageProcessor = ImageProcessing(image: image)

        imageProcessor.getImageText { detectedText, success in
            completion(detectedText, success)
        }
    }

    private func processDetectedText(_ detectedText: String?) {
        guard let detectedText = detectedText else {
            self.showMessage(isSuccessMessage: false, body: NSLocalizedString("no_text_detected", comment: ""))
            print("No text detected")
            return
        }

        StringUtils.matchNumbersString(inputString: detectedText) { matchedValues, success in
            if success {
                DispatchQueue.main.async {
                    if let intValue = Int(matchedValues) {
                        self.reading.kWhReading = intValue
                    } else {
                        self.showMessage(isSuccessMessage: false, body: NSLocalizedString("unknown_ocr_error", comment: ""))
                        print("Matched values could not be converted to an integer")
                    }
                }
            } else {
                self.showMessage(isSuccessMessage: false, body: NSLocalizedString("no_text_detected", comment: ""))
                print("No match found")
            }
        }
    }

    func showMessage(isSuccessMessage: Bool, body: String) {
        self.messageTitle = isSuccessMessage ? NSLocalizedString("success", comment: "") : NSLocalizedString("error", comment: "")
        self.messageBody = body
        self.showMessage = true
    }
}
