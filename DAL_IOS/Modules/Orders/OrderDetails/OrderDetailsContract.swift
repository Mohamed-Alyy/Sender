//
//  OrderDetailsContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol OrderDetailsPresenterContract: PresenterProtocol {
    func cancelOrder(for order: OrdersModel.Datum?)
    func editOrder(for order: OrdersModel.Datum?)
    func rateOrder(for order: OrdersModel.Datum?, rate: Double?, comment: String?)
}
// MARK: - ...  View Contract
protocol OrderDetailsViewContract: PresentingViewProtocol {
    func didFetchOrder(order: OrdersModel.Datum?)
    func didCancel()
    func didEdited()
    func didRated()
    func didError(error: String?)
}
// MARK: - ...  Router Contract
protocol OrderDetailsRouterContract: Router, RouterProtocol {
    func dismiss()
}

protocol OrderDetailsDelegate: AnyObject {
    func orderDetails(_ delegate: OrderDetailsDelegate?)
    func orderDetails(_ delegate: OrderDetailsDelegate?, forEdit: Bool)
}
