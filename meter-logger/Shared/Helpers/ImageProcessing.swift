//
//  ImageProcessing.swift
//  MeterLogger
//
//  Created by Oscar Rivera Moreira on 26/2/24.
//

import Foundation
import SwiftUI
import Vision

class ImageProcessing {
    
    @Published var image: UIImage

    init(image: UIImage) {
        self.image = image
    }

    func getImageText(completion: @escaping (String?, Bool) -> Void) {
        guard let ciImage = CIImage(image: image) else {
            completion(nil, false)
            return
        }

        let textRecognitionRequest = VNRecognizeTextRequest { request, error in
            if let error = error {
                print("Error in performing Text Recognition request: \(error)")
                completion(nil, false)
                return
            }

            guard let observations = request.results as? [VNRecognizedTextObservation] else {
                completion(nil, false)
                return
            }

            var detectedText = ""
            for observation in observations {
                guard let topCandidate = observation.topCandidates(1).first else { continue }
                detectedText += topCandidate.string + "\n"
            }

            completion(detectedText, true)
        }

        textRecognitionRequest.recognitionLevel = .accurate
        textRecognitionRequest.usesLanguageCorrection = true

        let textRecognitionRequestHandler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        DispatchQueue.global().async {
            do {
                try textRecognitionRequestHandler.perform([textRecognitionRequest])
            } catch {
                print("Error in performing Text Recognition request: \(error)")
                completion(nil, false)
            }
        }
    }
}
