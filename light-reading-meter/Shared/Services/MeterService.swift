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
}
