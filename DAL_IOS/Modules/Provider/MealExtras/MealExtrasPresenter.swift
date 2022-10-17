//
//  MealExtrasPresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/25/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class MealExtrasPresenter: BasePresenter<MealExtrasViewContract> {
}
// MARK: - ...  Presenter Contract
extension MealExtrasPresenter: MealExtrasPresenterContract {
}
// MARK: - ...  Example of network response
extension MealExtrasPresenter {
    func fetchResponse<T: MealExtrasModel>(response: NetworkResponse<T>) {
        switch response {
            case .success(_):
                break
            case .failure(_):
                break
        }
    }
}
