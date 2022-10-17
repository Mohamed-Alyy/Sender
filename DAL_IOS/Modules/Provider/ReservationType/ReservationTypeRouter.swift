//
//  ReservationTypeRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/24/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class ReservationTypeRouter: Router {
    typealias PresentingView = ReservationTypeVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension ReservationTypeRouter: ReservationTypeRouterContract {
    func meal() {
        view?.delegate?.reservationType(view?.delegate, meal: true)
        view?.dismiss(animated: true, completion: nil)
    }
    
    func reservation() {
        view?.delegate?.reservationType(view?.delegate, reservation: true)
        view?.dismiss(animated: true, completion: nil)
    }
    
    func none() {
        view?.dismiss(animated: true, completion: nil)
    }
}
