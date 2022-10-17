//
//  CartPresenter.swift
//  DAL_IOS
//
//  Created by rh.com.sa on 31/01/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class CartPresenter: BasePresenter<CartViewContract> {

}
// MARK: - ...  Presenter Contract
extension CartPresenter: CartPresenterContract {
    
    
    func sendOrder(addressID: Int?, paymentMethod: PaymentMethod?) {
//        if UserRoot.token() == nil {
//            UserRoot.authroize()
//            return
//        }
//        let cart = CartBuilder().fetch()
//        var cartIDS: [Int] = []
//        for item in cart?.cart ?? [] {
//            cartIDS.append(item.id ?? 0)
//        }
//        var paramters: [String: Any] = [:]
//        paramters["cart_id"] = cartIDS.toJson()
//        paramters["sub_total"] = cart?.subTotal
//        paramters["service"] = cart?.service
//        paramters["tax"] = cart?.tax
//        if addressID == nil {
//            paramters["service"] = 0
//            paramters["total"] = (cart?.total ?? 0)
//        } else {
//            paramters["total"] = (cart?.total ?? 0) + (cart?.service ?? 0)
//        }
//        if addressID != nil {
//            paramters["delivery_type"] = "outdoor"
//            paramters["address_id"] = addressID
//        } else {
//            paramters["delivery_type"] = "indoor"
//        }
//        paramters["payment_method"] = paymentMethod?.rawValue
//        if cart?.cart?.first?.orderID != nil {
//            editOrder(paramters: paramters)
//        } else {
//            NetworkManager.instance.paramaters = paramters
//            NetworkManager.instance.request(.order, type: .post, BaseModel<String>.self) { [weak self] (response) in
//                switch response {
//                    case .success(let model):
//                        CartBuilder.destroy()
//                        self?.view?.didFinishOrder()
//                    case .failure:
//                        break
//                }
//            }
//        }
    }
    func editOrder(paramters: [String: Any]) {
//        let cart = CartBuilder().fetch()
//        guard let orderID = cart?.cart?.first?.orderID else { return }
//        let method = NetworkConfigration.EndPoint.endPoint(point: .editOrder, paramters: [orderID])
//        NetworkManager.instance.paramaters = paramters
//        NetworkManager.instance.request(method, type: .post, BaseModel<String>.self) { [weak self] (response) in
//            switch response {
//                case .success(let model):
//                    CartBuilder.destroy()
//                    self?.view?.didFinishOrder()
//                case .failure:
//                    break
//            }
//        }
    }
}
// MARK: - ...  Example of network response
extension CartPresenter {
    
}
