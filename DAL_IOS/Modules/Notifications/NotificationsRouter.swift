//
//  NotificationsRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/20/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class NotificationsRouter: Router {
    typealias PresentingView = NotificationsVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension NotificationsRouter: NotificationsRouterContract {
    func navigateToOrder(orderID: Int?, tab: OrdersVC.Tab) {
        guard let scene = R.storyboard.orderDetailsStoryboard.orderDetailsVC() else { return }
        scene.tab = tab
        scene.orderID = orderID
        view?.pushPop(scene)
    }
    func navigateToReservation(reservationID: Int?, tab: OrdersVC.Tab) {
        guard let scene = R.storyboard.reservationDetailsStoryboard.reservationDetailsVC() else { return }
        scene.tab = tab
        scene.reservationID = reservationID
        view?.pushPop(scene)
    }
}
