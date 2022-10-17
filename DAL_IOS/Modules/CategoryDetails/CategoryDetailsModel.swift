// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let categoryDetailsModel = try? newJSONDecoder().decode(CategoryDetailsModel.self, from: jsonData)

import Foundation

// MARK: - CategoryDetailsModel
struct CategoryDetailsModel: Codable {
    let status: Bool?
    let data: [Provider]?
    let meta: Meta?
    
    // MARK: - Meta
    struct Meta: Codable {
        let total, count, perPage, currentPage: Int?
        let totalPages: Int?
        
        enum CodingKeys: String, CodingKey {
            case total, count
            case perPage = "per_page"
            case currentPage = "current_page"
            case totalPages = "total_pages"
        }
    }

}

// MARK: - Datum
class Provider: Codable, FavoriteBuilder {
    
    var id: Int?
    var name: String? {
        return self.attributes?.providerName
    }
    let email, phone, gender: String?
    let birthdate, address, lat, lng: String?
    let avatar: String?
    let active, rating: Int?
    let userType: String?
    let attributes: Attributes?
    let categories: [Category]?
    let subcategories: [Provider.SubCategory]?
    let features: [Feature]?
    let images: [Image]?
    let rates: [Rate]?
    let distance: String?
    var isLiked: Int?
    var minPrice: Double?
    var maxPrice: Double?
    enum CodingKeys: String, CodingKey {
        //case name
        case id, email, phone, gender, birthdate, address, lat, lng, avatar, active, rating
        case userType = "user_type"
        case attributes, categories, features, images, distance, isLiked, maxPrice, minPrice
        case subcategories, rates
    }
    
    // MARK: - Attributes
    struct Attributes: Codable {
        let id, userID, providerID: Int?
        let type: String?
        //let nationalityID: Int?
        let providerName, workHours, from, to: String?
        let providerStatus: Int?
        let minimumOrderPrice, freeOrderPrice, detailsAr, detailsEn: String?
        let facebook, twitter, instagarm, bankName, iban: String?
        let snapchat: String?
        let commercialRegister, commercialImg: String?
        let receiptImg: String?
        let mix: Int?
        //let meatType, meatSource, otherMeatSource: String?
        let deliveryOption, tableOption, priceAdded: Int?
        let createdAt, updatedAt: String?
        //let nationality: Nationality?
        let nationality: [MeatsOption.MeatType]?
        let meatTypes: [MeatsOption.MeatType]?
        let meatSources: [MeatsOption.MeatType]?
        let otherMeatSources: [MeatsOption.MeatType]?
        enum CodingKeys: String, CodingKey {
            case id
            case userID = "user_id"
            case providerID = "provider_id"
            case type
            //case nationalityID = "nationality_id"
            case providerName = "provider_name"
            case workHours = "work_hours"
            case from, to
            case minimumOrderPrice = "minimum_order_price"
            case freeOrderPrice = "free_order_price"
            case detailsAr = "details_ar"
            case detailsEn = "details_en"
            case facebook = "facebook"
            case twitter = "twitter"
            case instagarm = "instagarm"
            case snapchat
            case bankName = "bank_name"
            case iban
            case commercialRegister = "commercial_register"
            case commercialImg = "commercial_img"
            case receiptImg = "receipt_img"
            case mix
            //case meatType = "meat_type"
            //case meatSource = "meat_source"
            //case otherMeatSource = "other_meat_source"
            case deliveryOption = "delivery_option"
            case tableOption = "table_option"
            case priceAdded = "price_added"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case nationality
            case otherMeatSources
            case meatSources
            case meatTypes
            case providerStatus = "provider_status"

        }
    }
    
    // MARK: - Nationality
    struct Nationality: Codable {
        let id: Int?
        let nameAr, nameEn: String?
        var name: String? {
            if Localizer.current == .arabic {
                return nameAr
            } else {
                return nameEn
            }
        }
        let active: Int?
        let createdAt, updatedAt: String?
        let img: String?
        let type: String?
        let count: Int?
        
        enum CodingKeys: String, CodingKey {
            case id
            case nameAr = "name_ar"
            case nameEn = "name_en"
            case active
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case img, type
            case count
        }
    }
    
    // MARK: - Category
    struct Category: Codable {
        let id, categoryID, userID: Int?
        let createdAt, updatedAt: String?
        let category: Nationality?
        
        enum CodingKeys: String, CodingKey {
            case id
            case categoryID = "category_id"
            case userID = "user_id"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case category
        }
    }
    
    // MARK: - Feature
    struct Feature: Codable {
        let id, featureID, userID: Int?
        let createdAt, updatedAt: String?
        let feature: Nationality?
        
        enum CodingKeys: String, CodingKey {
            case id
            case featureID = "feature_id"
            case userID = "user_id"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
            case feature
        }
    }
    
    // MARK: - Image
    struct Image: Codable {
        let id: Int?
        let img: String?
        let userID: Int?
        let createdAt, updatedAt: String?
        
        enum CodingKeys: String, CodingKey {
            case id, img
            case userID = "user_id"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }
    }
    // MARK: - Rate
    struct Rate: Codable {
        let id, rating: Int?
        let comment: String?
        let userID, rateableID: Int?
        let rateableType, createdAt: String?
        let userImg: String?
        let userName: String?
        
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
    // MARK: - Nationality
    struct SubCategory: Codable {
        let id: Int?
        var name: String?
        let active: Int?
        let img: String?
        let count: Int?
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case active
            case img
            case count
        }
    }
}

// MARK: - MeatsOption
struct MeatsOption: Codable {
    let status: Bool?
    let data: DataClass?
    
    // MARK: - DataClass
    struct DataClass: Codable {
        let meatTypes, meatsources, otherMeatSources: [MeatType]?
    }

    // MARK: - MeatType
    struct MeatType: Codable {
        var id: Int?
        var name: String?
    }

}

 

// MARK: - Welcome
struct Welcome: Codable {
    let data: [Datum]?
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int?
    let name, email, phone, address: String?
    let lat, lng: String?
    let avatar: String?
    let active, rating: Int?
    let userType, distance: String?
    let isLiked, isRated, newNotifications: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, email, phone, address, lat, lng, avatar, active, rating
        case userType = "user_type"
        case distance, isLiked, isRated
        case newNotifications = "new_notifications"
    }
}
