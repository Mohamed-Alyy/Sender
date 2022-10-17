//
//  ReOrderPresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class ReOrderPresenter: BasePresenter<ReOrderViewContract> {
}
// MARK: - ...  Presenter Contract
extension ReOrderPresenter: ReOrderPresenterContract {
}
// MARK: - ...  Example of network response
extension ReOrderPresenter {
    func fetchResponse<T: ReOrderModel>(response: NetworkResponse<T>) {
        switch response {
            case .success(_):
                break
            case .failure(_):
                break
        }
    }
}
