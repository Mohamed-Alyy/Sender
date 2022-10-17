//
//  EndPoint.swift
//  SupportI
//
//  Created by Mohamed Abdu on 3/20/20.
//  Copyright © 2020 MohamedAbdu. All rights reserved.
//

import Foundation
import UIKit
// MARK: - ...  Network layer configration
struct NetworkConfigration {
    static let URL = "https://sender.sa/api/v1/"
//    static let URL = "https://sender.sa/public/api/v1"
    //static let URL = "https://dal-fd.com/public/api/v1/"
    static let VERSION = "v1"
    static var useAuth: Bool = false
    // MARK: - ...  The Endpoints
    public enum EndPoint: String {
        case point
        case token
        case login
        case resendCode
        case sendCode = "sendRegisterCode"
        case checkCode = "verifyRegisterCode"
        case register = "user/register"
        case forgotPasswordStep1 = "get-reset-password-code"
        case forgotPasswordStep2 = "verify-reset-password-code"
        case updatePassword
        case saveResetPassword = "save-reset-password"
        case profile
        case product
        case home
        case categories
        case providers
        case filterOptions
        case search
        case favorites
        case rates = "providerRates"
        case userProducts
        case addAddress
        case myAddresses = "my-addresses"
        case deleteAddress = "userAddress"
        case settings
        case cart
        case reservation
        case reservations
        case orders
        case order
        case myFavourite
        case rate = "rateOrder"
        case reorder
        case filterOrder
        case questions
        case contact
        case notifications
        case editCartOrder
        case editOrder
        case refuseOrder
        case cities
        case refuseReservation
        case rules
        case terms
        case contactInfo = "contact-info"
        case changePassword = "change-password"
        case myCards = "my-cards"
        case providerCategories = "provider-categories"
        case menuCategories = "menu-categories"
        case ads
        case products
        case areas
        case addToCart = "my-cart/addToCart2"
        case editCart = "my-cart/editCart"
        case myCart = "my-cart"
        case couponDetails = "coupon-details"
        case suggestedProducts = "suggested-products"
        case myCarts = "my-carts"
        case providerRatings = "provider/ratings"
        case wallet
        case withdraw = "wallet/withdraw"
        case banks
        case about
        case deleteAccount = "request-delete-account"
        
        //case orderDetail = "order"
    }
}

extension NetworkConfigration.EndPoint {
    static func endPoint(point: NetworkConfigration.EndPoint, paramters: [Any]) -> String {
        let method = NetworkManager.instance.slugs(point, paramters)
        return method
    }
}

