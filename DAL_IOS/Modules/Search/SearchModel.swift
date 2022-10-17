//
//  SearchModel.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/18/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
class SearchModel: Codable {
}

// MARK: - FilterModel
struct FilterOptionModel: Codable {
    let status: Bool?
    let data: DataClass?
    // MARK: - DataClass
    struct DataClass: Codable {
        let nationality: [Feature]?
        let products: [String]?
        let categories, subcategories: [Category]?
        let features: [Feature]?
        let places: [Feature]?
        let distances: [Distance]?
    }
    
    // MARK: - Category
    struct Category: Codable, FilterModel {
        var id: Int?
        let img: String?
        var name: String?
        let count: Int?
        let type: String?
        let active, categoryID: Int?
        var checked: Bool?
        enum CodingKeys: String, CodingKey {
            case id, img, name, count, type, active
            case categoryID = "category_id"
            case checked
        }
    }
    
    // MARK: - Feature
    struct Feature: Codable, FilterModel, TagModel {
        var id: Int?
        var name: String?
        let active: Int?
        var checked: Bool?
    }
    // MARK: - Feature
    struct Distance: Codable, FilterModel {
        var checked: Bool?
        var id: Int?
        var name: String?
        enum CodingKeys: String, CodingKey {
            case id, checked
            case name = "distance"
        }
    }

}

