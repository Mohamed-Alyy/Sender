//
//  OrderDetailsPresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class OrderDetailsPresenter: BasePresenter<OrderDetailsViewContract> {
}
// MARK: - ...  Presenter Contract
extension OrderDetailsPresenter: OrderDetailsPresenterContract {
    func fetchOrder(orderID: Int?) {
        //new, processing, finished, canceled
        let method = NetworkConfigration.EndPoint.endPoint(point: .orders, paramters: [orderID ?? 0])
        NetworkManager.instance.request(method, type: .get, OrderDetailsModel.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                self?.view?.didFetchOrder(order: model?.data)
                case .failure:
                    self?.view?.stopLoading()

            }
        }
    }
    func cancelOrder(for order: OrdersModel.Datum?) {
        if UserRoot.token() == nil {
            UserRoot.authroize()
            return
        }
        guard let orderId = order?.id else {return}
        let method = NetworkConfigration.EndPoint.endPoint(point: .orders, paramters: [orderId, "cancel"])
        NetworkManager.instance.request(method, type: .post, BaseModel<String>.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    self?.view?.didCancel()
                case .failure:
                    break
            }
        }
    }
    
    func editOrder(for order: OrdersModel.Datum?) {
        if UserRoot.token() == nil {
            UserRoot.authroize()
            return
        }
        let method = NetworkConfigration.EndPoint.endPoint(point: .editCartOrder, paramters: [order?.id ?? 0])
        NetworkManager.instance.request(method, type: .post, CartModel.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    model?.save()
                    self?.view?.didEdited()
                case .failure:
                    break
            }
        }
    }
    
    func rateOrder(for order: OrdersModel.Datum?, rate: Double?, comment: String?) {
        if UserRoot.token() == nil {
            UserRoot.authroize()
            return
        }
//        if !setupRateArray(for: order) {
//            view?.didError(error: "Please rate the products first!".localized)
//            return
//        }
        
        NetworkManager.instance.paramaters["rating"] = rate
        NetworkManager.instance.paramaters["comment"] = comment
        let method = NetworkConfigration.EndPoint.endPoint(point: .orders, paramters: [order?.id ?? 0, "rate"])
        NetworkManager.instance.request(method, type: .post, BaseModel<String>.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                self?.view?.didRated()
                case .failure(let error):
                self?.view?.didError(error: error?.localizedDescription)
            }
        }
    }
    
//    func setupRateArray(for order: OrdersModel.Datum?) -> Bool {
//        var rates: [Int] = []
//        let ids = order?.items?.map({ item -> Int in
//            guard let rate = item.rateValue?.int else { return item.productID ?? 0 }
//            if rate > 0 {
//                rates.append(rate)
//            }
//            return item.productID ?? 0
//        })
//        guard let idsProducts = ids else { return false }
//        if idsProducts.count != rates.count {
//            return false
//        }
//        let idsJson = try? JSONEncoder().encode(idsProducts)
//        let ratesJson = try? JSONEncoder().encode(rates)
//        NetworkManager.instance.paramaters["products[id]"] = String(data: idsJson ?? Data(), encoding: .utf8)
//        NetworkManager.instance.paramaters["products[rate]"] = String(data: ratesJson ?? Data(), encoding: .utf8)
//        return true
//    }
}
// MARK: - ...  Example of network response
extension OrderDetailsPresenter {

}
