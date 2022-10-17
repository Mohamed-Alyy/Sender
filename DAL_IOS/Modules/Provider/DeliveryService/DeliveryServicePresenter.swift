//
//  DeliveryServicePresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/20/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class DeliveryServicePresenter: BasePresenter<DeliveryServiceViewContract> {
}
// MARK: - ...  Presenter Contract
extension DeliveryServicePresenter: DeliveryServicePresenterContract {
}
// MARK: - ...  Example of network response
extension DeliveryServicePresenter {
    func fetchResponse<T: DeliveryServiceModel>(response: NetworkResponse<T>) {
        
        switch response {
            case .success(_):
                break
            case .failure(_):
                break
        }
    }
}
