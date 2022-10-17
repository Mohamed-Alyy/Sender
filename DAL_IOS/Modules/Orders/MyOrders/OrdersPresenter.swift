//
//  OrdersPresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class OrdersPresenter: BasePresenter<OrdersViewContract> {
}
// MARK: - ...  Presenter Contract
extension OrdersPresenter: OrdersPresenterContract {
    func fetchOrders(tab: OrdersVC.Tab) {
        guard let view = view as? OrdersVC else {return}
        if tab == .new {
            NetworkManager.instance.paramaters["status"] = "new"
        } else if tab == .processing {
            NetworkManager.instance.paramaters["status"] = "pending"
        } else {
            NetworkManager.instance.paramaters["status"] = "finished"
        }
        NetworkManager.instance.request(.orders, type: .get, OrdersModel.self) { [weak self] (response) in
            defer {view.stopLoading() }
            switch response {
                case .success(let model):
                    self?.view?.didFetch(for: model?.data)
                case .failure:
                    break
            }
        }
    }
    func reOrder(for order: OrdersModel.Datum?) {
        if UserRoot.token() == nil {
            UserRoot.authroize()
            return
        }
        
        NetworkManager.instance.paramaters["order_id"] = order?.id
        NetworkManager.instance.request(.reorder, type: .post, BaseModel<String>.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    self?.view?.stopLoading()
                    self?.view?.didReOrderd()
                case .failure:
                    break
            }
        }
    }
}
// MARK: - ...  Example of network response
extension OrdersPresenter {
}
