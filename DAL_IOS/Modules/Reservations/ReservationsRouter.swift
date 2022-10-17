//
//  ReservationsRouter.swift
//  DAL_Provider
//
//  Created by Mabdu on 28/02/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class ReservationsRouter: Router {
    typealias PresentingView = ReservationsVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension ReservationsRouter: ReservationsRouterContract {
    func reservation(for reservation: ReservationsModel.Datum?) {
        guard let scene = R.storyboard.reservationDetailsStoryboard.reservationDetailsVC() else { return }
        scene.delegate = view
        scene.tab = view?.currentTab ?? .new
        scene.reservation = reservation
        view?.pushPop(scene)
    }
    func filter() {
        guard let scene = R.storyboard.reservationsFilterStoryboard.reservationsFilterVC() else { return }
        scene.delegate = view
        view?.pushPop(scene)
    }
}
