//
//  MeterService.swift
//  light-reading-meter
//
//  Created by Oscar Rivera Moreira on 14/2/24.
//

import Foundation

class MeterService {
    private let apiClient = APIClient.shared
    static let shared = MeterService()
    
    func getMeters(completion: @escaping (Bool, [Meter], String?) -> ()) {
        apiClient.call(endpoint: "todos", method: .GET, params: nil, httpHeader: .none) { success, data in
            guard success, let data = data else {
                completion(false, [], "Error: Meter GET Request failed")
                return
            }
            
            do {
                // TODO: Implement this when the backend is ready.
                // let meters = try JSONDecoder().decode([Meter].self, from: data)
                
                let fakeMeters = [
                    Meter(name: "Medidor de casa", tag: "Oscar", currentReading: 30, desiredMonthlyKWH: 150),
                    Meter(name: "Medidor de mama", tag: "Mama", currentReading: 130, desiredMonthlyKWH: 150),
                    Meter(name: "Medidor de aire acondicionado", tag: "Johana", currentReading: 155,  desiredMonthlyKWH: 150)
                ]
                
                completion(true, fakeMeters, nil)
            } catch {
                completion(false, [], "Error: Parsing Meter failed")
            }
        }
    }
    
    func getMeterById(id: UUID, completion: @escaping (Bool, Meter?, String?) -> ()) {
        apiClient.call(endpoint: "todos/\(id)", method: .GET, params: nil, httpHeader: .none) { success, data in
            
            let fakeReadings = [
                Reading(meterId: UUID(), kWhReading: 1633, accumulatedkWhReading: 33, dateOfReading: Date(), isLastCycle: true),
                Reading(meterId: UUID(), kWhReading: 1630, accumulatedkWhReading: 30, dateOfReading: Date(), isLastCycle: false)
            ]
            
            let fakeMeter = Meter(name: "Medidor de casa", tag: "Oscar", lastBillingKwh: 1660, lastInvoice: Date(), currentReading: 30, desiredMonthlyKWH: 150, lastReadings: fakeReadings)

            completion(true, fakeMeter, nil)
            return
            
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
            "desiredMonthlyKWH": String(meter.desiredMonthlyKWH)
        ]
        
        apiClient.call(endpoint: "todos", method: .POST, params: deserializedMeter, httpHeader: .none) { success, data in
            guard success, let data = data else {
                completion(false, "Error: Meter Post Request failed")
                return
            }
            
            do {
                // TODO: Implement this when the backend is ready.
                // let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
                
                let response: [String: String] = [
                    "message": "Meter created successfully",
                    "translationKey": "meter_created_successfully",
                    "ok": "true"
                ]
                
                completion(true, response["message"])
            } catch {
                completion(false, "Error: Parsing Meter failed")
            }
        }
    }
    
    func updateMeter(meter: Meter, completion: @escaping (Bool, String?) -> ()) {
        
        let deserializedMeter: [String: String] = [
            "name": meter.name,
            "tag": meter.tag,
            "desiredMonthlyKWH": String(meter.desiredMonthlyKWH)
        ]
        
        apiClient.call(endpoint: "todos/\(meter.id)", method: .PUT, params: deserializedMeter, httpHeader: .none) { success, data in
            
            let response: [String: String] = [
                "message": "Meter updated successfully",
                "translationKey": "meter_updated_successfully",
                "ok": "true"
            ]

            completion(true, response["message"])

            return
            
            guard success, let data = data else {
                completion(false, "Error: Meter Put Request failed")
                return
            }
            
            do {
                // TODO: Implement this when the backend is ready.
                // let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
                
                let response: [String: String] = [
                    "message": "Meter updated successfully",
                    "translationKey": "meter_updated_successfully",
                    "ok": "true"
                ]
                
                completion(true, response["message"])
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
                // TODO: Implement this when the backend is ready.
                // let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String]
                
                let response: [String: String] = [
                    "message": "Meter deleted successfully",
                    "translationKey": "meter_deleted_successfully",
                    "ok": "true"
                ]
                
                completion(true, response["message"])
            } catch {
                completion(false, "Error: Parsing Meter failed")
            }
        }
    }
}
