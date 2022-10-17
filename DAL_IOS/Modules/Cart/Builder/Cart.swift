//
//  Cart.swift
//  DAL_IOS
//
//  Created by rh.com.sa on 31/01/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//


import Foundation

struct CartResponse: Codable {
    let data: CartModel?
}


// MARK: - CartModel
struct CartModel: Codable, Cached {
    let id: Int?
        let provider: ProvidersResult?
        let price: String?
        let items: [Cart]?
        let taxAmount, deliveryPrice, totalPrice: String?

        enum CodingKeys: String, CodingKey {
            case id, provider, price, items
            case taxAmount = "tax_amount"
            case deliveryPrice = "delivery_price"
            case totalPrice = "total_price"
        }
 
    
    // MARK: - Datum
    class Cart: Codable,QuantityModel {
        var stock: Int? 
        var id: Int?
        let product: ProductCart?
        let itemType: String?
        let additions: [AdditionsModel]?
        var peicePrice, total: String?
        var quantity: Int?
        

        enum CodingKeys: String, CodingKey {
            case id, product, stock
            case itemType = "item_type"
            case additions
            case peicePrice = "peice_price"
            case quantity, total
        }
    }
    
    // MARK: - Product
    struct ProductCart: Codable {
        let id: Int?
        let name: String?
        let image: String?
        let price: String?
        let calories: Int?
        let stock: Int?
    }
}





// MARK: - CartModel
//struct CartModel: Codable, Cached {
//    var status: Bool?
//    var data: DataClass?
//
//    // MARK: - DataClass
//    struct DataClass: Codable {
//        let cart: [Cart]?
//        let subTotal, tax, service, total: Double?
//        let provider: Provider?
//        enum CodingKeys: String, CodingKey {
//            case cart
//            case subTotal = "sub_total"
//            case tax, service, total
//            case provider
//        }
//    }
//
//    // MARK: - Cart
//    struct Cart: Codable {
//        let id: Int?
//        let productName: String?
//        let productID: Int?
//        let extraID, extraQty: [Int]?
//        let userID, qty: Int?
//        let price: Double?
//        let notes: String?
//        let productImg: String?
//        let orderID: Int?
//        let productPrice: Double?
//        enum CodingKeys: String, CodingKey {
//            case id
//            case productName = "product_name"
//            case productID = "product_id"
//            case extraID = "extra_id"
//            case extraQty = "extra_qty"
//            case userID = "user_id"
//            case price, qty, notes
//            case productImg = "product_img"
//            case orderID = "order_id"
//            case productPrice = "product_price"
//        }
//    }
//
//}
