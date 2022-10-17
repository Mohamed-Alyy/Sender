//
//  CheckoutModel.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 14/09/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation


class CheckoutModel {
    var cartId: Int
    var tax: Double?
    var price: Double?
    var total: Double?
    var deliveryPrice: Double?
    var addressId: Int?
    var addressName: String?
    var addressDes: String?
    var userLat: String?
    var userLng: String?
    
    init(cartId: Int,tax: Double?,price: Double?,total: Double?,deliveryPrice: Double?){
        self.cartId = cartId
        self.tax = tax
        self.price = price
        self.total = total
        self.deliveryPrice = deliveryPrice
    } 
    
}


struct CouponModel: Codable {
    var data: Coupon?
    
    struct Coupon: Codable{
        var discount_amount: Double?
        var discount_type_key: String?
    }
   
}


// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct CreateOrderModel: Codable {
    let data: CreateOrderDataClass?
}

// MARK: - DataClass
struct CreateOrderDataClass: Codable {
    let id: Int?
    let status, statusKey: String?
    let payment: Payment?
    let user, provider: ProvidersResult?
    let address: Address?
    let coupon, subTotal, deliveryPrice: Int?
    let tax, total: Double?

    enum CodingKeys: String, CodingKey {
        case id, status
        case statusKey = "status_key"
        case payment, user, provider, address, coupon
        case subTotal = "sub_total"
        case deliveryPrice = "delivery_price"
        case tax, total
    }
}

// MARK: - Address
struct Address: Codable {
    let id: Int?
    let createdAt, name, type, typeKey: String?
    let lat, lng, addressDescription: String?
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

// MARK: - Payment
struct Payment: Codable {
    let paymentStatus, paymentStatusKey, paymentMethod, paymentMethodKey: String?

    enum CodingKeys: String, CodingKey {
        case paymentStatus = "payment_status"
        case paymentStatusKey = "payment_status_key"
        case paymentMethod = "payment_method"
        case paymentMethodKey = "payment_method_key"
    }
}
 
