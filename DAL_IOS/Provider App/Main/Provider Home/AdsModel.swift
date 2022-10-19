//
//  AdvModel.swift
//  DAL_IOS
//
//  Created by Mohamed Khaled on 18/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation
struct AdsApiModel: Codable {
    let data: [AdsDatum]
}

// MARK: - Datum
struct AdsDatum: Codable {
    let id: Int
    let title, startAt, endAt: String
    let pic: String
    let link: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case startAt = "start_at"
        case endAt = "end_at"
        case pic, link
    }
}
