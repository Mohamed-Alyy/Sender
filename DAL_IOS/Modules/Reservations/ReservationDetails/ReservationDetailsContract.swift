//
//  OrderDetailsContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol ReservationDetailsPresenterContract: PresenterProtocol {
    func fetchReservation(reservationID: Int?)
    func rateReservation(for reservation: ReservationsModel.Datum?, rate: Double?, comment: String?)
}
// MARK: - ...  View Contract
protocol ReservationDetailsViewContract: PresentingViewProtocol {
    func didFetchReservation(reservation: ReservationsModel.Datum?)
    func didRated()
    func didCancel()
    func didEdited()
}
// MARK: - ...  Router Contract
protocol ReservationDetailsRouterContract: Router, RouterProtocol {
    func dismiss()
}

protocol ReservationDetailsDelegate: class {
    func reservationDetails(_ delegate: ReservationDetailsDelegate?)
}
