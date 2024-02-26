//
//  ReadingService.swift
//  meter-logger
//
//  Created by Oscar Rivera Moreira on 17/2/24.
//

import Foundation

class ReadingService {
    private let apiClient = APIClient.shared
    static let shared = ReadingService()

    func saveReading(reading: Reading, completion: @escaping (Bool, String?) -> ()) {
        let deserializedReading: [String: String] = [
            "meter": reading.meterId,
            "KwhReading": String(reading.kWhReading),
            "dateOfReading": reading.dateOfReadingString,
            "isCutoffDate": String(reading.isCutoffDate)
        ]

        apiClient.call(endpoint: "readings", method: .POST, params: deserializedReading, httpHeader: .application_json) { success, data in
            guard success, let data = data else {
                completion(false, "Error: Reading Post Request failed")
                return
            }

            do {
                let response = try JSONDecoder().decode(ServeResponse.self, from: data)
                completion(response.ok, NSLocalizedString(response.translationKey, comment: ""))
            } catch {
                print(error)
                completion(false, "Error: Parsing Reading failed")
            }
        }
    }

    func updateReading(reading: Reading, completion: @escaping (Bool, String?) -> ()) {

        let deserializedReading: [String: String] = [
            "meter": reading.meterId,
            "KwhReading": String(reading.kWhReading),
            "dateOfReading": reading.dateOfReadingString,
            "isCutoffDate": String(reading.isCutoffDate)
        ]

        apiClient.call(endpoint: "readings/\(reading.id)", method: .PUT, params: deserializedReading, httpHeader: .application_json) { success, data in
            guard success, let data = data else {
                completion(false, "Error: Reading Put Request failed")
                return
            }

            do {
                let response = try JSONDecoder().decode(ServeResponse.self, from: data)

                completion(response.ok, NSLocalizedString(response.translationKey, comment: ""))
            } catch {
                completion(false, "Error: Parsing Reading failed")
            }
        }
    }

    func deleteReading(id: String, completion: @escaping (Bool, String?) -> ()) {
        apiClient.call(endpoint: "readings/\(id)", method: .DELETE, params: nil, httpHeader: .none) { success, data in
            guard success, let data = data else {
                completion(false, "Error: Reading Delete Request failed")
                return
            }

            do {
                let response = try JSONDecoder().decode(ServeResponse.self, from: data)

                completion(response.ok, NSLocalizedString(response.translationKey, comment: ""))
            } catch {
                completion(false, "Error: Parsing Meter failed")
            }
        }
    }
}
