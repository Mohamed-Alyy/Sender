//
//  ProviderDetailsModel.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/21/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
class ProviderCategoriesModel: Codable {
    let data: [ProviderCategoriesDatum]?
}

// MARK: - Datum
class ProviderCategoriesDatum: Codable {
    let id: Int?
    let title: String?
    let image: String?
    let productsCount: Int?
    var isSelected: Bool = false

    enum CodingKeys: String, CodingKey {
        case id, title, image
        case productsCount = "products_count"
    }
}

 

// MARK: - Welcome
struct ProviderRatingsModel: Codable {
    let data: [ProviderRatingsDatum]?
}

// MARK: - Datum
struct ProviderRatingsDatum: Codable {
    let id, rating: Int?
    let comment: String?
    let provider: ProvidersResult?
    let user: User?
    let created_at: String?
}

// MARK: - User
struct User: Codable {
    let id: Int?
    let name: String?
    let avatar: String?
    let phone: String?
}
