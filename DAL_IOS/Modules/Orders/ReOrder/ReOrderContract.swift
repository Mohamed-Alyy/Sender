//
//  ReOrderContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol ReOrderPresenterContract: PresenterProtocol {
}
// MARK: - ...  View Contract
protocol ReOrderViewContract: PresentingViewProtocol {
}
// MARK: - ...  Router Contract
protocol ReOrderRouterContract: Router, RouterProtocol {
    func reOrder()
    func dismiss()
}

protocol ReOrderDelegate: class {
    func reOrder(_ delegate: ReOrderDelegate?, for order: OrdersModel.Datum?)
}
