// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let ordersModel = try? newJSONDecoder().decode(OrdersModel.self, from: jsonData)

import Foundation

// MARK: - OrdersModel
struct OrderDetailsModel: Codable {
    let data: OrdersModel.Datum?
}

struct OrdersModel: Codable {
    let data: [Datum]?
    
    // MARK: - Datum
    struct Datum: Codable {
        let id: Int?
        let status: String?
        let statusKey: String?
        let payment: Payment?
        let times: Times?
        let user: Provider?
        let provider: ProvidersResult?
        let address: Address?
        let coupon,notes: String?
        let items: [Item]?
        let subTotal, deliveryPrice, tax, total,discount_amount: String?

        enum CodingKeys: String, CodingKey {
            case id, status
            case statusKey = "status_key"
            case payment, times, user, provider, address, coupon, items
            case subTotal = "sub_total"
            case deliveryPrice = "delivery_price"
            case tax, total,notes,discount_amount
        }
    }
    
    
    // MARK: - Address
    struct Address: Codable {
        let id: Int?
        let createdAt: String?
        let name: String?
        let type: String?
        let typeKey: String?
        let lat, lng: String?
        let addressDescription: String?
        let isDefault: Int?

        enum CodingKeys: String, CodingKey {
            case id
            case createdAt = "created_at"
            case name, type
            case typeKey = "type_key"
            case lat, lng
            case addressDescription = "description"
            case isDefault = "is_default"
        }
    }
    
    // MARK: - Item
    struct Item: Codable {
        let id, cartItemID: Int?
        let product: Product?
        let itemType: String?
        let peicePrice, total: String?
        let quantity: Int?
        let additions: [AdditionsModel]?

        enum CodingKeys: String, CodingKey {
            case id
            case cartItemID = "cart_item_id"
            case product
            case itemType = "item_type"
            case peicePrice = "peice_price"
            case quantity, total, additions
        }
    }
    
    // MARK: - Product
    struct Product: Codable {
        let id: Int?
        let name: String?
        let image: String?
        let price: String?
        let calories, stock: Int?
    }
    
    // MARK: - Payment
    struct Payment: Codable {
        let paymentStatus: String?
        let paymentStatusKey: String?
        let paymentMethod: String?
        let paymentMethodKey: String?

        enum CodingKeys: String, CodingKey {
            case paymentStatus = "payment_status"
            case paymentStatusKey = "payment_status_key"
            case paymentMethod = "payment_method"
            case paymentMethodKey = "payment_method_key"
        }
    }
    
    // MARK: - Provider
    struct Provider: Codable {
        let id: Int?
        let name: String?
    }
    
    // MARK: - Times
    struct Times: Codable {
        let createdAt: String?
        let preparingAt, preparationTime, preparationTimeEndsAt, readyAt: String?
        let refusedAt: String?
        let deliveringAt, finishedAt, canceledAt: String?

        enum CodingKeys: String, CodingKey {
            case createdAt = "created_at"
            case preparingAt = "preparing_at"
            case preparationTime = "preparation_time"
            case preparationTimeEndsAt = "preparation_time_ends_at"
            case readyAt = "ready_at"
            case refusedAt = "refused_at"
            case deliveringAt = "delivering_at"
            case finishedAt = "finished_at"
            case canceledAt = "canceled_at"
        }
    }
}



 



 
 


 
