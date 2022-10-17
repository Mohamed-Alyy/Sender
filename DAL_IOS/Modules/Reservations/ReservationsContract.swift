//
//  ReservationsContract.swift
//  DAL_Provider
//
//  Created by Mabdu on 28/02/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol ReservationsPresenterContract: PresenterProtocol {
    func fetchReservations(tab: OrdersVC.Tab)
    func filterReservations(filter: ReservationsFilterModel?)
}
// MARK: - ...  View Contract
protocol ReservationsViewContract: PresentingViewProtocol {
    func didFetch(for list: [ReservationsModel.Datum]?)
}
// MARK: - ...  Router Contract
protocol ReservationsRouterContract: Router, RouterProtocol {
    func filter()
    func reservation(for reservation: ReservationsModel.Datum?)
}
