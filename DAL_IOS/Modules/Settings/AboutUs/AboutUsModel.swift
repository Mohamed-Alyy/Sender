//
//  AboutUsModel.swift
//  DAL_Provider
//
//  Created by Mabdu on 02/03/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
class AboutUsModel: Codable {
    let status: Bool?
    let data: DataClass?
    
    // MARK: - DataClass
    struct DataClass: Codable {
        let tax, service, email, phone, address: String?
        let facebook, snabchat, instagram: String?
        let about_ar: String?
        let about_en: String?
        var about_us: String? {
            get {
                if Localizer.current == .arabic {
                    return about_ar
                } else {
                    return about_en
                }
            }
        }
    }

}

// MARK: - Welcome
struct AboutModel: Codable {
    let contactInfo: ContactInfo?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case contactInfo = "contact_info"
        case content
    }
}

// MARK: - DataClass
struct ContactInfo: Codable {
    let phone, email, address: String?
    let facebook: String?
    let snabchat, instagram: String?
}
 


