//
//  ReservationTypeContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/24/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol ReservationTypePresenterContract: PresenterProtocol {
}
// MARK: - ...  View Contract
protocol ReservationTypeViewContract: PresentingViewProtocol {
}
// MARK: - ...  Router Contract
protocol ReservationTypeRouterContract: Router, RouterProtocol {
    func meal()
    func reservation()
    func none()
}

protocol ReservationTypeDelegate: class {
    func reservationType(_ delegate: ReservationTypeDelegate?, meal: Bool)
    func reservationType(_ delegate: ReservationTypeDelegate?, reservation: Bool)
}
