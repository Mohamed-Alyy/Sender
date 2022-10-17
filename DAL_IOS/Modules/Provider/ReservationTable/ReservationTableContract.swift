//
//  ReservationTableContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/25/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol ReservationTablePresenterContract: PresenterProtocol {
    func fetchFilter()
    func book(bookModel: ReservationTableModel?)
}
// MARK: - ...  View Contract
protocol ReservationTableViewContract: PresentingViewProtocol {
    func didFetchFilter(for model: FilterOptionModel.DataClass?)
    func didBooked()
}
// MARK: - ...  Router Contract
protocol ReservationTableRouterContract: Router, RouterProtocol {
    func didBooked(booked: Bool?)
}

protocol ReservationTableDelegate: class {
    func reservationTable(_ delegate: ReservationTableDelegate?, for book: ReservationTableModel?)
}
