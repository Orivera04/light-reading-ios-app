//
//  Reading.swift
//  meter-logger
//
//  Created by Oscar Rivera Moreira on 16/2/24.
//

import Foundation

struct Reading: Identifiable, Codable {
    // Properties
    var id: String
    var meterId: String
    var kWhReading: Int
    var dateOfReading: Date
    var isCutoffDate: Bool
    var accumulatedkWhReading: Int

    // Constructor
    init(id:String = "",
         meterId: String = "",
         kWhReading: Int = 0,
         accumulatedkWhReading: Int = 0,
         dateOfReading: Date = Date(),
         isCutoffDate: Bool = false) {
       self.meterId = meterId
       self.kWhReading = kWhReading
       self.accumulatedkWhReading = accumulatedkWhReading
       self.dateOfReading = dateOfReading
       self.isCutoffDate = isCutoffDate
       self.id = id
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case meterId = "meter"
        case kWhReading = "KwhReading"
        case accumulatedkWhReading
        case dateOfReading
        case isCutoffDate = "isCutoffDate"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"

        id = try values.decode(String.self, forKey: .id)
        meterId = try values.decode(String.self, forKey: .meterId)
        kWhReading = try values.decode(Int.self, forKey: .kWhReading)
        accumulatedkWhReading = try values.decode(Int.self, forKey: .accumulatedkWhReading)

        let dateOfReadingValue = try values.decode(String.self, forKey: .dateOfReading)
        dateOfReading = dateFormatter.date(from: dateOfReadingValue)!

        isCutoffDate = try values.decode(Bool.self, forKey: .isCutoffDate)
    }

    // Decorators
    var kilowatsReadingString: String {
        return "\(Int(kWhReading)) KWH"
    }

    var kilowatsAcumulatedReadingString: String {
        return "\(Int(accumulatedkWhReading)) KWH"
    }

    var dateOfReadingString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        return dateFormatter.string(from: dateOfReading)
    }

    // Validations

    var isValid: Bool {
        return kWhReading > 0
    }

    var errors: [String] {
        var errorMessages: [String] = []

        if kWhReading <= 0 {
            errorMessages.append(NSLocalizedString("kwh_is_not_valid", comment: ""))
        }


        return errorMessages
    }

    var showModelErrors: String {
        return errors.joined(separator: "\n")
    }

}
