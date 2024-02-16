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
                    Meter(name: "Medidor de casa", kWh: 30, tag: "Oscar", desiredMonthlyKWH: 150),
                    Meter(name: "Medidor de mama", kWh: 130, tag: "Mama", desiredMonthlyKWH: 150),
                    Meter(name: "Medidor de aire acondicionado", kWh: 155, tag: "Johana", desiredMonthlyKWH: 150)
                ]
                
                completion(true, fakeMeters, nil)
            } catch {
                completion(false, [], "Error: Parsing Meter failed")
            }
        }
    }
    
    func saveMeter(meter: Meter, completion: @escaping (Bool, String?) -> ()) {
        
        let deserializedMeter: [String: String] = [
            "id": meter.id.uuidString,
            "name": meter.name,
            "kWh": String(meter.kWh),
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
}
