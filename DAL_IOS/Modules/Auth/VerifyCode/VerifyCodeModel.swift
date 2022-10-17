//
//  VerifyCodeModel.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - VerifyCodeModel
struct VerifyCodeModel: Codable {
    let status: Bool?
    let msg: String?
    let data: DataClass?
    
    // MARK: - DataClass
    struct DataClass: Codable {
        let id: Int?
        let phone: String?
        let active: Int?
        let createdAt, updatedAt: String?
        
        enum CodingKeys: String, CodingKey {
            case id, phone
            case active
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }
    }

}



struct VerifyCodeResetPasswordModel: Codable {
    let message: String?
    let secret_code: String
}
