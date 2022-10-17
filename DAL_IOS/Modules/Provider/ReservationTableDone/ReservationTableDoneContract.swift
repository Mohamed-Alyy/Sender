//
//  ReservationTableDoneContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/25/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol ReservationTableDonePresenterContract: PresenterProtocol {
}
// MARK: - ...  View Contract
protocol ReservationTableDoneViewContract: PresentingViewProtocol {
}
// MARK: - ...  Router Contract
protocol ReservationTableDoneRouterContract: Router, RouterProtocol {
    func didDone(go reservations: Bool?)
}

protocol ReservationDoneDelegate: class {
    func reservationDone(_ delegate: ReservationDoneDelegate?)
}
