//
//  ReservationTableDonePresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/25/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class ReservationTableDonePresenter: BasePresenter<ReservationTableDoneViewContract> {
}
// MARK: - ...  Presenter Contract
extension ReservationTableDonePresenter: ReservationTableDonePresenterContract {
}
// MARK: - ...  Example of network response
extension ReservationTableDonePresenter {
    func fetchResponse<T: ReservationTableDoneModel>(response: NetworkResponse<T>) {
        switch response {
            case .success(_):
                break
            case .failure(_):
                break
        }
    }
}
