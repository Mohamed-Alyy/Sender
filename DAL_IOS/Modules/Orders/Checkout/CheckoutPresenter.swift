//
//  CheckoutPresenter.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 14/09/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class CheckoutPresenter: BasePresenter<CheckoutViewContract> {
}
// MARK: - ...  Presenter Contract
extension CheckoutPresenter: CheckoutPresenterContract {
    
    func applyCopoun() {
        guard let view = view as? CheckoutVC else {return}
        guard let copoun = view.discountCodeTF.text else {return}
        view.startLoading()
      
        let method = NetworkConfigration.EndPoint.endPoint(point: .couponDetails, paramters: [copoun])
        NetworkManager.instance.request(method, type: .get, CouponModel.self) { [weak self] (response) in
            defer {view.stopLoading() }
            switch response {
                case .success(let model):
                guard let model = model else { 
                    return
                }
                self?.view?.applyCopoun(couponModel: model)
                case .failure(let error):
                self?.view?.didError(error: error?.localizedDescription)
            }
        }
    }
    
    func createOrder() {
        guard let view = view as? CheckoutVC else {return}
        guard let cartId = view.checkoutModel?.cartId else {return}
        view.startLoading()
        let method = NetworkConfigration.EndPoint.endPoint(point: .orders, paramters: [cartId])
        NetworkManager.instance.paramaters["payment_method"] = "cash"
        NetworkManager.instance.paramaters["discount_code"] = view.discountCodeTF.text ?? nil
        NetworkManager.instance.paramaters["notes"] = view.noteTF.text ?? nil
        NetworkManager.instance.paramaters["address_id"] = view.checkoutModel?.addressId
        
        NetworkManager.instance.request(method, type: .post, CreateOrderModel.self) { [weak self] (response) in
            defer{ view.stopLoading()}
            switch response {
                case .success(_):
                    self?.view?.didCreate()
                case .failure(let error):
                self?.view?.didError(error: error?.localizedDescription)
            }
        }
    }
     
}

