//
//  ReservationsFilterContract.swift
//  DAL_IOS
//
//  Created by Mabdu on 16/02/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol ReservationsFilterPresenterContract: PresenterProtocol {
}
// MARK: - ...  View Contract
protocol ReservationsFilterViewContract: PresentingViewProtocol {
}
// MARK: - ...  Router Contract
protocol ReservationsFilterRouterContract: Router, RouterProtocol {
    func didApply(for apply: Bool?)
}

protocol ReservationFilterDelegate: class {
    func reservationFilter(_ delegate: ReservationFilterDelegate?, for filter: ReservationsFilterModel?)
}
