// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let addressesModel = try? newJSONDecoder().decode(AddressesModel.self, from: jsonData)

import Foundation

// MARK: - AddressesModel
struct AddressesModel: Codable {
    let data: [Datum]?
    
    // MARK: - Datum
    class Datum: Codable {
        let id: Int?
        let createdAt, name, type, typeKey: String?
        let lat, lng, datumDescription: String?
        let isDefault: Int?
        var addressCity: String?
        var isSelected: Bool = false

        enum CodingKeys: String, CodingKey {
            case id
            case createdAt = "created_at"
            case name, type
            case typeKey = "type_key"
            case lat, lng
            case datumDescription = "description"
            case isDefault = "is_default"
        }
    }
}

