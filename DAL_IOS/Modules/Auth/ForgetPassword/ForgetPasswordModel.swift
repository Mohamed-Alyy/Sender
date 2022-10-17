//
//  ForgetPasswordModel.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
class ForgetPasswordModel: Codable {
    var message: String?
    var user_id: Int?
    var secret_code: String?
}
