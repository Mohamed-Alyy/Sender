// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let homeModel = try? newJSONDecoder().decode(HomeModel.self, from: jsonData)

import Foundation

// MARK: - HomeModel
struct HomeModel: Codable {
    let status: Bool?
    let data: DataClass?
    
    // MARK: - DataClass
    struct DataClass: Codable {
        var ads: [Ad]?
        var categories: [Category]?
        var products: [Product]?
    }
    
    // MARK: - Ad
    struct Ad: Codable {
        let id: Int?
        let titleAr, titleEn, detailsAr, detailsEn: String?
        let img, link: String?
        let active, sort, userID: Int?
        let createdAt, updatedAt: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case titleAr = "title_ar"
            case titleEn = "title_en"
            case detailsAr = "details_ar"
            case detailsEn = "details_en"
            case img, link, active, sort
            case userID = "user_id"
            case createdAt = "created_at"
            case updatedAt = "updated_at"
        }
    }
    
    // MARK: - Category
    struct Category: Codable {
        let id: Int?
        let img: String?
        let name: String?
        let count: Int?
        let type: String?
        let active: Int?
        
        enum CategoryType: String {
            case resturant = "RESTURANT"
            case coffe = "COFFE"
        }
        func getType() -> CategoryType? {
            return CategoryType(rawValue: type ?? "")
        }
    }
}

// MARK: - Product
struct Product: Codable {
    let id, userID, categoryID, subCategoryID: Int?
    let name: String?
    let price: String?
    let calory, details: String?
    let img: String?
    let date, providerName, categoryName, subcategoryName: String?
    let rating: Double?
    let active: Int?
    let additions: [Addition]?
    let rates: [Rate]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case categoryID = "category_id"
        case subCategoryID = "sub_category_id"
        case name, price, calory, details, img, date
        case providerName = "provider_name"
        case categoryName = "category_name"
        case subcategoryName = "subcategory_name"
        case rating, active, additions, rates
    }
    
    // MARK: - Addition
    struct Addition: Codable {
        let id, productID: Int?
        let name: String?
        let price: Int?
        let img: String?
        
        enum CodingKeys: String, CodingKey {
            case id
            case productID = "product_id"
            case name, price, img
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

}

 

// MARK: - Welcome
struct CategoriesModel: Codable {
    let data: [CategoriesResult]?
}

// MARK: - Datum
struct CategoriesResult: Codable, FilterModel {
    var name: String? {
        get { self.title }
        set { self.title = newValue }
    }
    var id: Int?
    var checked: Bool?
    var title: String?
    let image: String?
    let providers_count: Int?
    
    enum CategoryType: Int {
        case Juice = 28
        case Resutrant = 30
    }
    func getType() -> CategoryType? {
        return CategoryType(rawValue: id ?? 0)
    }
}
 
// MARK: - Welcome
struct AdsModel: Codable {
    let data: [AdsResult]?
}

// MARK: - Datum
struct AdsResult: Codable {
    let id: Int?
    let title: String?
    let startAt, endAt: String?
    let pic: String?
    let link: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case startAt = "start_at"
        case endAt = "end_at"
        case pic, link
    }
}
