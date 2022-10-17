//
//  CartContract.swift
//  DAL_IOS
//
//  Created by rh.com.sa on 31/01/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol CartPresenterContract: PresenterProtocol {
    func sendOrder(addressID: Int?, paymentMethod: PaymentMethod?)
}
// MARK: - ...  View Contract
protocol CartViewContract: PresentingViewProtocol {
    func sendOrder(addressID: Int?)
    func didFinishOrder()
    
}
// MARK: - ...  Router Contract
protocol CartRouterContract: Router, RouterProtocol {
    func addMeal()
    func makeOrder(checkoutModel: CheckoutModel)
    func addresses()
    func home()
    func mealDetails(for meal: Int?)
    func makeOrderDone()
}


enum PaymentMethod: String {
    case cash = "cash"
    case mada = "mada"
    case halla = "hala"
}
