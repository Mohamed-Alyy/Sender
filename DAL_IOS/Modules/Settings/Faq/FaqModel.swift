//
//  FaqModel.swift
//  DAL_Provider
//
//  Created by Mabdu on 02/03/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
class FaqModel: Codable {
    let status: Bool?
    let data: [Datum]?
    // MARK: - Datum
    struct Datum: Codable {
        let id: Int?
        let question, answer, createdAt, updatedAt: String?

        enum CodingKeys: String, CodingKey {
            case id, question, answer
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }
    }

}
