//
//  ReservationsFilterPresenter.swift
//  DAL_IOS
//
//  Created by Mabdu on 16/02/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class ReservationsFilterPresenter: BasePresenter<ReservationsFilterViewContract> {
}
// MARK: - ...  Presenter Contract
extension ReservationsFilterPresenter: ReservationsFilterPresenterContract {
}
// MARK: - ...  Example of network response
extension ReservationsFilterPresenter {
    func fetchResponse<T: ReservationsFilterModel>(response: NetworkResponse<T>) {
        switch response {
            case .success(_):
                break
            case .failure(_):
                break
        }
    }
}
