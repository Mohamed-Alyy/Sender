//
//  ReservationsFilterRouter.swift
//  DAL_IOS
//
//  Created by Mabdu on 16/02/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class ReservationsFilterRouter: Router, ReservationsFilterRouterContract {
    typealias PresentingView = ReservationsFilterVC
    weak var view: ReservationsFilterVC?
    deinit {
        self.view = nil
    }
    
    func didApply(for apply: Bool?) {
        if apply == true {
            view?.delegate?.reservationFilter(self.view?.delegate, for: self.view?.filter)
        }
        view?.dismiss(animated: true, completion: nil)
    }
}
