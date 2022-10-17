//
//  OrdersRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class OrdersRouter: Router {
    typealias PresentingView = OrdersVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension OrdersRouter: OrdersRouterContract {
    func reOrder(for order: OrdersModel.Datum?) {
        guard let scene = R.storyboard.reOrderStoryboard.reOrderVC() else { return }
        scene.order = order
        scene.delegate = self
        view?.pushPop(scene)
    }
    
    func order(for order: OrdersModel.Datum?) {
        guard let scene = R.storyboard.orderDetailsStoryboard.orderDetailsVC() else { return }
        scene.tab = view?.currentTab ?? .new
        scene.order = order
        scene.delegate = view
        view?.pushPop(scene)
    }
    func cart() {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.050) {
            guard let scene = R.storyboard.cartStoryboard.cartVC() else { return }
            self.view?.push(scene)
        }
    }
}

extension OrdersRouter: ReOrderDelegate {
    func reOrder(_ delegate: ReOrderDelegate?, for order: OrdersModel.Datum?) {
        view?.startLoading()
        view?.presenter?.reOrder(for: order)

    }
}
