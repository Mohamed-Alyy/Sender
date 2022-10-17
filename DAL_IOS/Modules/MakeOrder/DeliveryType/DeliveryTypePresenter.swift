//
//  DeliveryTypePresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/2/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class DeliveryTypePresenter: BasePresenter<DeliveryTypeViewContract> {
}
// MARK: - ...  Presenter Contract
extension DeliveryTypePresenter: DeliveryTypePresenterContract {
}
// MARK: - ...  Example of network response
extension DeliveryTypePresenter {
    func fetchResponse<T: DeliveryTypeModel>(response: NetworkResponse<T>) {
        switch response {
            case .success(_):
                break
            case .failure(_):
                break
        }
    }
}
