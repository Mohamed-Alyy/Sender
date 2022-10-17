//
//  CartModel.swift
//  DAL_IOS
//
//  Created by rh.com.sa on 31/01/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation



protocol CartBuilderViewContract: AnyObject {
    func didFinishProcessOnCart()
    func didFetchMyCart(cart: CartModel)
}


// MARK: - ...  Cart Protocol
protocol Cart: QuantityModel {
    // MARK: - ...  Item price
    var price: String? { set get }
    
    // MARK: - ...  Price for each item with extras
    func priceForItem() -> Double
    func extrasIDS() -> [Int]
    func extrasQTY() -> [Int]
}
//extension Cart {
//    func item() -> CartItem {
//        let model = CartItem()
//        model.id = self.id
//        model.quantity = self.quantity
//        model.price = self.priceForItem()
//        return model
//    }
//}

//class CartItem: Codable {
//    var price: Double?
//    var id: Int?
//    var quantity: Int?
//}
