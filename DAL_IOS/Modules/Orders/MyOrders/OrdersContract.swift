//
//  OrdersContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol OrdersPresenterContract: PresenterProtocol {
    func fetchOrders(tab: OrdersVC.Tab)
    func reOrder(for order: OrdersModel.Datum?) 
}
// MARK: - ...  View Contract
protocol OrdersViewContract: PresentingViewProtocol {
    func didFetch(for list: [OrdersModel.Datum]?)
    func didReOrderd()
}
// MARK: - ...  Router Contract
protocol OrdersRouterContract: Router, RouterProtocol {
    func reOrder(for order: OrdersModel.Datum?)
    func order(for order: OrdersModel.Datum?)
}
