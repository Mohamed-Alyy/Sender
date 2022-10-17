//
//  ContactUsModel.swift
//  DAL_Provider
//
//  Created by Mabdu on 02/03/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
class ContactUsModel: Codable {
    var email: String?
    var name: String?
    var message: String?
    var address: String?
    var whatsapp: String?
}
// MARK: - ContactResponseModel
struct ContactResponseModel: Codable {
    let status: Bool?
    let message: String?
    let data: DataClass?
    
    // MARK: - DataClass
    struct DataClass: Codable {
        let message, title: String?
        let userID: Int?
        let updatedAt, createdAt: String?
        let id: Int?

        enum CodingKeys: String, CodingKey {
            case message, title
            case userID = "user_id"
            case updatedAt = "updated_at"
            case createdAt = "created_at"
            case id
        }
    }

}
