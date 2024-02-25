//
//  MeterService.swift
//  meter-logger
//
//  Created by Oscar Rivera Moreira on 14/2/24.
//

import Foundation

class MeterService {
    private let apiClient = APIClient.shared
    static let shared = MeterService()

    func getMeters(completion: @escaping (Bool, ListMeterHome, String?) -> ()) {
        apiClient.call(endpoint: "meters", method: .GET, params: nil, httpHeader: .none) { success, data in
            guard success, let data = data else {
                completion(false, ListMeterHome(), "Error: Meter GET Request failed")
                return
            }

            do {
                let meters: ListMeterHome = try JSONDecoder().decode(ListMeterHome.self, from: data)
                completion(true, meters, nil)
            } catch {
                print("Error: \(error)")
                completion(false, ListMeterHome(), "Error: Parsing Meter failed")
            }
        }
    }

    func getMeterById(id: String, completion: @escaping (Bool, Meter?, String?) -> ()) {
        apiClient.call(endpoint: "meters/\(id)", method: .GET, params: nil, httpHeader: .none) { success, data in

            guard success, let data = data else {
                completion(false, nil, "Error: Meter GET Request failed")
                return
            }

            do {
                let meter = try JSONDecoder().decode(Meter.self, from: data)
                completion(true, meter, nil)
            } catch {
                print("Error decoding JSON: \(error)")
                completion(false, nil, "Error: Parsing Meter failed")
            }
        }
    }

    func saveMeter(meter: Meter, completion: @escaping (Bool, String?) -> ()) {

        let deserializedMeter: [String: String] = [
            "name": meter.name,
            "tag": meter.tag,
            "desiredKwhMonthly": String(meter.desiredKwhMonthly)
        ]
        
        apiClient.call(endpoint: "meters", method: .POST, params: deserializedMeter, httpHeader: .application_json) { success, data in
            guard success, let data = data else {
                completion(false, "Error: Meter Post Request failed")
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

    func updateMeter(meter: Meter, completion: @escaping (Bool, String?) -> ()) {

        let deserializedMeter: [String: String] = [
            "name": meter.name,
            "tag": meter.tag,
            "desiredKwhMonthly": String(meter.desiredKwhMonthly)
        ]

        apiClient.call(endpoint: "meters/\(meter.id)", method: .PUT, params: deserializedMeter, httpHeader: .application_json) { success, data in
            guard success, let data = data else {
                completion(false, "Error: Meter Put Request failed")
                return
            }

            do {
                let response = try JSONDecoder().decode(ServeResponse.self, from: data)

                completion(response.ok, NSLocalizedString(response.translationKey, comment: ""))
            } catch {
                print(error)
                completion(false, "Error: Parsing Meter failed")
            }
        }
    }

    func deleteMeterById(id: String, completion: @escaping (Bool, String?) -> ()) {
        apiClient.call(endpoint: "meters/\(id)", method: .DELETE, params: nil, httpHeader: .none) { success, data in
            guard success, let data = data else {
                completion(false, "Error: Meter Delete Request failed")
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
