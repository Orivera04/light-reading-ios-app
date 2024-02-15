//
//  HttpRequestHelper.swift
//  light-reading-meter
//
//  Created by Oscar Rivera Moreira on 14/2/24.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum HTTPHeaderFields {
    case application_json
    case application_x_www_form_urlencoded
    case none
}

class APIManager {
    static let shared = APIManager()
    
    private let baseURL = "https://jsonplaceholder.typicode.com/"
    
    private init() {}
    
    func call(endpoint: String, method: HTTPMethod, params: [String: String]?, httpHeader: HTTPHeaderFields, complete: @escaping (Bool, Data?) -> ()) {
        let urlString = baseURL + endpoint
        
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        switch httpHeader {
        case .application_json:
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        case .application_x_www_form_urlencoded:
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        case .none: break
        }
        
        if let params = params {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            } catch let error {
                print("Error serializing JSON: \(error.localizedDescription)")
                complete(false, nil)
                return
            }
        }
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: problem calling \(method.rawValue)")
                print(error!)
                complete(false, nil)
                return
            }
            guard let data = data else {
                print("Error: did not receive data")
                complete(false, nil)
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 300) ~= response.statusCode else {
                print("Error: HTTP request failed")
                complete(false, nil)
                return
            }
            complete(true, data)
        }.resume()
    }
}
