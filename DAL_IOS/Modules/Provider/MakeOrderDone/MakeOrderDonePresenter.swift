//
//  MakeOrderDonePresenter.swift
//  DAL_IOS
//
//  Created by Mabdu on 24/03/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class MakeOrderDonePresenter: BasePresenter<MakeOrderDoneViewContract> {
}
// MARK: - ...  Presenter Contract
extension MakeOrderDonePresenter: MakeOrderDonePresenterContract {
}
// MARK: - ...  Example of network response
extension MakeOrderDonePresenter {
    func fetchResponse<T: MakeOrderDoneModel>(response: NetworkResponse<T>) {
        switch response {
            case .success(_):
                break
            case .failure(_):
                break
        }
    }
}
