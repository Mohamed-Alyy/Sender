//
//  SearchResultContainerModel.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/18/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct ProvidersModel: Codable {
    let data: [ProvidersResult]?
}

// MARK: - Datum
struct ProvidersResult: Codable,FavoriteBuilder {
    var id: Int?
    let name, email, phone, address: String?
    let lat, lng: String?
    let avatar: String?
    let active, rating: Int?
    let isOnline: Int?
    let userType, distance: String?
    var isLiked, isRated, newNotifications: Int?
    let category: CategoryData?

    enum CodingKeys: String, CodingKey {
        case id, name, email, phone, address, lat, lng, avatar, active, rating,category
        case userType = "user_type"
        case distance, isLiked, isRated
        case newNotifications = "new_notifications"
        case isOnline = "is_online"
    }
}

struct CategoryData: Codable {
    var id: Int?
    var title: String? 
}
