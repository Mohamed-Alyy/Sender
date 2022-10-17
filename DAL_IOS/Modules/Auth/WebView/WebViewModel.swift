//
//  WebViewModel.swift
//  DAL_Provider
//
//  Created by Mabdu on 05/05/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - NotificationsModel
struct WebViewModel: Codable {
    let status: Bool?
    let data: DataClass?
    
    // MARK: - DataClass
    struct DataClass: Codable {
        let rulesAr, rulesEn: String?

        enum CodingKeys: String, CodingKey {
            case rulesAr = "rules_ar"
            case rulesEn = "rules_en"
        }
    }

}

