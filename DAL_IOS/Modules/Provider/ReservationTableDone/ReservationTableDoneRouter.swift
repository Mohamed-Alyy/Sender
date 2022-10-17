//
//  ReservationTableDoneRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/25/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class ReservationTableDoneRouter: Router {
    typealias PresentingView = ReservationTableDoneVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension ReservationTableDoneRouter: ReservationTableDoneRouterContract {
    func didDone(go reservations: Bool? = nil) {
        view?.dismiss(animated: true, completion: {
            if reservations != nil {
                self.view?.delegate?.reservationDone(self.view?.delegate)
            }
        })
    }
}
