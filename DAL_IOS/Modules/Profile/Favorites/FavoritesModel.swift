//
//  FavoritesModel.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
class FavoritesModel<T: Codable>: Codable {
    let status: Bool?
    let data: [T]?
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
    }
    required init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        status = try? container?.decode(Bool.self, forKey: .status)
        data = try? container?.decode([T].self, forKey: .data)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(status, forKey: .status)
        try? container.encode(data, forKey: .data)
    }
}
