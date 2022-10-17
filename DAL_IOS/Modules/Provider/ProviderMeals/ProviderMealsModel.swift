//
//  ProviderMealsModel.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/24/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let mealsModel = try? newJSONDecoder().decode(MealsModel.self, from: jsonData)

import Foundation

// MARK: - MealsModel
class ProviderMealsModel: Codable {
    let status: Bool?
    let data: [Meal]?
}
// MARK: - Datum
class Meal: Codable, Cart, FavoriteBuilder {
    var stock: Int?
    
    var price: String?
    var id: Int?
    var quantity: Int?
    var userID, categoryID, subCategoryID: Int?
    var name: String?
    var calory, details: String?
    var img: String?
    var date, providerName, categoryName, subcategoryName: String?
    var rating, active: Int?
    var additions: [Addition]?
    var rates: [Rate]?
    var isLiked: Int?
    var note: String?
    func priceForItem() -> Double {
        var price: Double = 0.0
        
        var extraPrices = 0.0
        for extra in additions ?? [] {
            if extra.isChecked == true && extra.quantity ?? 0 > 0 {
                let extraPrice = (Double(extra.price ?? "0") ?? 0) * (extra.quantity ?? 0).double
                extraPrices += extraPrice
            }
        }
        if extraPrices > 0 && ( self.quantity == nil || self.quantity ?? 0 == 0) {
            self.quantity = 1
        }
        price += (self.quantity ?? 0).double * (Double(self.price ?? "0") ?? 0)
        price += extraPrices
        return price
    }
    func extrasIDS() -> [Int] {
        var ids: [Int] = []
        for extra in additions ?? [] {
            if extra.isChecked == true && extra.quantity ?? 0 > 0 {
                ids.append(extra.id ?? 0)
            }
        }
        return ids
    }
    func extrasQTY() -> [Int] {
        var qty: [Int] = []
        for extra in additions ?? [] {
            if extra.isChecked == true && extra.quantity ?? 0 > 0 {
                qty.append(extra.quantity ?? 0)
            }
        }
        return qty
    }
    enum CodingKeys: String, CodingKey {
        case id
        case price
        case quantity
        case userID = "user_id"
        case categoryID = "category_id"
        case subCategoryID = "sub_category_id"
        case name, calory, details, img, date
        case providerName = "provider_name"
        case categoryName = "category_name"
        case subcategoryName = "subcategory_name"
        case rating, active, additions, rates
        case isLiked
        case note
    }

    // MARK: - Addition
    class Addition: Codable, QuantityModel {
        var stock: Int?
        var id, productID: Int?
        let name: String?
        let price: String?
        let img: String?
        var quantity: Int?
        var isChecked: Bool?
        enum CodingKeys: String, CodingKey {
            case id
            case productID = "product_id"
            case name, price, img
            case quantity
            case isChecked,stock
        }
    }
    
    // MARK: - Rate
    struct Rate: Codable {
        let id, rating: Int?
        let comment: String?
        let userID, rateableID: Int?
        let rateableType, createdAt, userImg, userName: String?
        
        enum CodingKeys: String, CodingKey {
            case id, rating, comment
            case userID = "user_id"
            case rateableID = "rateable_id"
            case rateableType = "rateable_type"
            case createdAt = "created_at"
            case userImg = "user_img"
            case userName = "user_name"
        }
    }

}



// MARK: - Welcome
struct ProviderCategoriesMealsModel: Codable {
    let data: [ProviderCategoriesMealsDatum]?
}

struct ProviderCategoriesMealsDetailsModel: Codable {
    let data: ProviderCategoriesMealsDatum?
}

// MARK: - Datum
struct ProviderCategoriesMealsDatum: Codable,QuantityModel {
    var id: Int?
    var status: String?
    var menuCategory: MenuCategory?
    var name: String?
    var price: String?
    var calories: Int?
    var datumDescription: String?
    var image: String?
    var provider: ProviderModel?
    var rating: Int?
    var additions: [AdditionsModel]?
    var rates: [RatesModel]?
    var isLiked: Int?
    var quantity: Int?
    var stock: Int?

    enum CodingKeys: String, CodingKey {
        case id, status
        case menuCategory = "menu_category"
        case name, price, calories
        case datumDescription = "description"
        case image, provider, rating, additions, rates, isLiked, stock
    }
}

// MARK: - MenuCategory
struct MenuCategory: Codable {
    let id: Int?
    let title: String?
}

// MARK: - Provider
struct ProviderModel: Codable {
    let id: Int?
    let name: String?
}

class AdditionsModel: Codable,QuantityModel {
    var quantity: Int?
    var id: Int?
    var name: String?
    var price: String?
    var productId: Int?
    var calories: Int?
    var stock: Int?
    var datumDescription: String?
    var image: String?
    var isChecked: Bool = false
    var peicePrice: String?
    var additionId: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, name, price, calories,stock, image,quantity
        case productId = "product_id"
        case datumDescription = "description"
        case peicePrice = "peice_price"
        case additionId = "addition_id"
    }
}

struct RatesModel: Codable {
    
}
