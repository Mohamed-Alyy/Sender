//
//  ReservationTypePresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/24/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class ReservationTypePresenter: BasePresenter<ReservationTypeViewContract> {
}
// MARK: - ...  Presenter Contract
extension ReservationTypePresenter: ReservationTypePresenterContract {
}
// MARK: - ...  Example of network response
extension ReservationTypePresenter {
    func fetchResponse<T: ReservationTypeModel>(response: NetworkResponse<T>) {
        switch response {
            case .success(_):
                break
            case .failure(_):
                break
        }
    }
}
