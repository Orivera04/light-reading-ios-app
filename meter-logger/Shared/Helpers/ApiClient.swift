//
//  HttpRequestHelper.swift
//  meter-logger
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

class APIClient {
    static let shared = APIClient()
    private let baseURL = Bundle.main.infoDictionary?["API_URL"] as! String

    private init() {}

    func call(endpoint: String, method: HTTPMethod, params: [String: String]?, httpHeader: HTTPHeaderFields, complete: @escaping (Bool, Data?) -> ()) {
        let urlString = baseURL + endpoint

        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
        }

        let request = buildRequest(url: url, method: method, params: params, httpHeader: httpHeader)

        let session = URLSession.shared
        session.dataTask(with: request) { [self] data, response, error in
            self.handleResponse(data: data, response: response, error: error, complete: complete)
        }.resume()
    }

    func buildRequest(url: URL, method: HTTPMethod, params: [String: String]?, httpHeader: HTTPHeaderFields) -> URLRequest {
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
            }
        }

        return request
    }

    func handleResponse(data: Data?, response: URLResponse?, error: Error?, complete: @escaping (Bool, Data?) -> ()) {
        guard error == nil else {
            print("Error: problem calling")
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
    }
}
