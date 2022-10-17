//
//  CheckoutContract.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 14/09/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol CheckoutPresenterContract: PresenterProtocol {
    func createOrder()
    func applyCopoun()
}
// MARK: - ...  View Contract
protocol CheckoutViewContract: PresentingViewProtocol {
    func didCreate()
    func applyCopoun(couponModel: CouponModel)
    func didError(error: String?)
}
// MARK: - ...  Router Contract
protocol CheckoutRouterContract: Router, RouterProtocol {
    func didCreate()
}

 
