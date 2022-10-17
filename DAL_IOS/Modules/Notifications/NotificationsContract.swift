//
//  NotificationsContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/20/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol NotificationsPresenterContract: PresenterProtocol {
    func fetchNotifications()
}
// MARK: - ...  View Contract
protocol NotificationsViewContract: PresentingViewProtocol {
    func didFetch(for list: [NotificationsModel.Datum])
}
// MARK: - ...  Router Contract
protocol NotificationsRouterContract: Router, RouterProtocol {
    func navigateToOrder(orderID: Int?, tab: OrdersVC.Tab)
    func navigateToReservation(reservationID: Int?, tab: OrdersVC.Tab)
}
