//
//  ReservationTableRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/25/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class ReservationTableRouter: Router {
    typealias PresentingView = ReservationTableVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension ReservationTableRouter: ReservationTableRouterContract {
    func didBooked(booked: Bool? = nil) {
        view?.dismiss(animated: true, completion: {
            if booked != nil {
                self.view?.delegate?.reservationTable(self.view?.delegate, for: self.view?.bookModel)
            }
        })
    }
}
