//
//  WalletModel.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 22/09/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct WalletModel: Codable {
    let data: [WalletDatum]?
    let wallet_balance: Double?
}

// MARK: - Datum
struct WalletDatum: Codable {
    let id: Int?
    let type, typeKey: String?
    let amount: Int?
    let notes, createAt: String?

    enum CodingKeys: String, CodingKey {
        case id, type
        case typeKey = "type_key"
        case amount, notes
        case createAt = "create_at"
    }
}
