//
//  ReadingService.swift
//  light-reading-meter
//
//  Created by Oscar Rivera Moreira on 17/2/24.
//

import Foundation

class ReadingService {
    private let apiClient = APIClient.shared
    static let shared = ReadingService()


    func saveReading(reading: Reading, completion: @escaping (Bool, String?) -> ()) {
        let deserializedReading: [String: String] = [
            "kWhReading": reading.kilowatsReadingString,
            "dateOfReading": reading.dateOfReadingString
        ]

        apiClient.call(endpoint: "todos", method: .POST, params: deserializedReading, httpHeader: .none) { success, data in
            guard success, let data = data else {
                completion(false, "Error: Reading Post Request failed")
                return
            }

            do {
                let response = try JSONDecoder().decode(ServeResponse.self, from: data)

                completion(true, response.message)
            } catch {
                completion(false, "Error: Parsing Reading failed")
            }
        }
    }

    func updateReading(reading: Reading, completion: @escaping (Bool, String?) -> ()) {

        let deserializedReading: [String: String] = [
            "kWhReading": reading.kilowatsReadingString,
            "dateOfReading": reading.dateOfReadingString
        ]

        apiClient.call(endpoint: "todos/\(reading.id)", method: .PUT, params: deserializedReading, httpHeader: .none) { success, data in
            guard success, let data = data else {
                completion(false, "Error: Reading Put Request failed")
                return
            }

            do {
                let response = try JSONDecoder().decode(ServeResponse.self, from: data)

                completion(true, response.message)
            } catch {
                completion(false, "Error: Parsing Reading failed")
            }
        }
    }

    func deleteReading(id: UUID, completion: @escaping (Bool, String?) -> ()) {
        apiClient.call(endpoint: "todos/\(id)", method: .DELETE, params: nil, httpHeader: .none) { success, data in
            guard success, let data = data else {
                completion(false, "Error: Reading Delete Request failed")
                return
            }

            do {
                let response = try JSONDecoder().decode(ServeResponse.self, from: data)

                completion(true, response.message)
            } catch {
                completion(false, "Error: Parsing Meter failed")
            }
        }
    }
}
