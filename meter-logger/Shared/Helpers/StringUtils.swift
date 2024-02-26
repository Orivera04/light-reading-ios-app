//
//  StringUtils.swift
//  MeterLogger
//
//  Created by Oscar Rivera Moreira on 26/2/24.
//

import Foundation

class StringUtils {

    static func matchNumbersString(inputString: String, completion: @escaping (String, Bool) -> Void) {
        let pattern = #"\b([0-9]+)\b"#

        guard let regex = try? NSRegularExpression(pattern: pattern, options: []) else {
            print("Invalid regex pattern")
            completion("", false)
            return
        }

        let range = NSRange(location: 0, length: inputString.utf16.count)
        let matches = regex.matches(in: inputString, options: [], range: range)

        var matchedValues = [String]()

        // Iterate through matches and extract matched values
        for match in matches {
            if let range = Range(match.range, in: inputString) {
                let matchedValue = String(inputString[range])
                matchedValues.append(matchedValue)
            }
        }

        let success = !matchedValues.isEmpty

        completion(matchedValues.joined(separator: ", "), success)
    }
}
