//
//  CardsListModel.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 08/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation
// MARK: - Welcome
struct CardsListModel: Codable {
    let data: [Datum]?
    
    // MARK: - Datum
    struct Datum: Codable {
        let id: Int?
        let createdAt, cardNumber, cardHolder: String?
        let expirationYear, expirationMonth, cvv, isDefault: Int?

        enum CodingKeys: String, CodingKey {
            case id
            case createdAt = "created_at"
            case cardNumber = "card_number"
            case cardHolder = "card_holder"
            case expirationYear = "expiration_year"
            case expirationMonth = "expiration_month"
            case cvv
            case isDefault = "is_default"
        }
    }
}


