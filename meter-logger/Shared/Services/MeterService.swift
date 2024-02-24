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

    func getMeters(completion: @escaping (Bool, [Meter], String?) -> ()) {
        apiClient.call(endpoint: "meters", method: .GET, params: nil, httpHeader: .none) { success, data in
            guard success, let data = data else {
                completion(false, [], "Error: Meter GET Request failed")
                return
            }

            do {
                var meterList: [Meter] = []
                let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                let meters = (jsonData?["meters"] as? [[String: Any]]) ?? []
                
                for meter in meters {
                    if let name = meter["name"] as? String,
                       let tag = meter["tag"] as? String,
                       let currentReading = meter["currentReading"] as? Int,
                       let desiredMonthlyKWH = meter["desiredKwhMonthly"] as? Int {
                       let newMeter = Meter(name: name, tag: tag, currentReading: currentReading, desiredMonthlyKWH: desiredMonthlyKWH)

                       meterList.append(newMeter)
                    }
                }

                completion(true, meterList, nil)
            } catch {
                completion(false, [], "Error: Parsing Meter failed")
            }
        }
    }

    func getMeterById(id: UUID, completion: @escaping (Bool, Meter?, String?) -> ()) {
        apiClient.call(endpoint: "meters/\(id)", method: .GET, params: nil, httpHeader: .none) { success, data in

            guard success, let data = data else {
                completion(false, nil, "Error: Meter GET Request failed")
                return
            }

            do {
                let meter = try JSONDecoder().decode(Meter.self, from: data)

                completion(true, meter, nil)
            } catch {
                completion(false, nil, "Error: Parsing Meter failed")
            }
        }
    }

    func saveMeter(meter: Meter, completion: @escaping (Bool, String?) -> ()) {

        let deserializedMeter: [String: String] = [
            "name": meter.name,
            "tag": meter.tag,
            "desiredMonthlyKWH": String(meter.desiredKwhMonthly)
        ]

        apiClient.call(endpoint: "meters", method: .POST, params: deserializedMeter, httpHeader: .none) { success, data in
            guard success, let data = data else {
                completion(false, "Error: Meter Post Request failed")
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

    func updateMeter(meter: Meter, completion: @escaping (Bool, String?) -> ()) {

        let deserializedMeter: [String: String] = [
            "name": meter.name,
            "tag": meter.tag,
            "desiredMonthlyKWH": String(meter.desiredKwhMonthly)
        ]

        apiClient.call(endpoint: "meters/\(meter.id)", method: .PUT, params: deserializedMeter, httpHeader: .none) { success, data in
            guard success, let data = data else {
                completion(false, "Error: Meter Put Request failed")
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

    func deleteMeterById(id: UUID, completion: @escaping (Bool, String?) -> ()) {
        apiClient.call(endpoint: "todos/\(id)", method: .DELETE, params: nil, httpHeader: .none) { success, data in
            guard success, let data = data else {
                completion(false, "Error: Meter Delete Request failed")
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
