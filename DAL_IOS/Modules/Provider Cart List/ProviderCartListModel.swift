//
//  ProviderCartListModel.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 15/09/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct ProviderCartListModel: Codable {
    let data: [ProviderCartListDatum]?
}

// MARK: - Datum
struct ProviderCartListDatum: Codable {
    let id, cartID: Int?
    let provider: ProviderCartList?
    let price, taxAmount, deliveryPrice, totalPrice: String?

    enum CodingKeys: String, CodingKey {
        case id
        case cartID = "cart_id"
        case provider, price
        case taxAmount = "tax_amount"
        case deliveryPrice = "delivery_price"
        case totalPrice = "total_price"
    }
}

// MARK: - Provider
struct ProviderCartList: Codable {
    let id, isOnline: Int?
    let name, email, phone, address: String?
    let lat, lng: String?
    let avatar: String?
    let active, rating: Int?
    let userType: String?
    let category: Category?
    let distance: String?
    let isLiked, isFavorite, isRated, newNotifications: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case isOnline = "is_online"
        case name, email, phone, address, lat, lng, avatar, active, rating
        case userType = "user_type"
        case category, distance, isLiked
        case isFavorite = "is_favorite"
        case isRated
        case newNotifications = "new_notifications"
    }
}

// MARK: - Category
struct Category: Codable {
    let id: Int?
    let title: String?
}

 
