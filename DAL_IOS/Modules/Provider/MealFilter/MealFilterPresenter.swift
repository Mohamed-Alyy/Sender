//
//  MealFilterPresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/24/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class MealFilterPresenter: BasePresenter<MealFilterViewContract> {
}
// MARK: - ...  Presenter Contract
extension MealFilterPresenter: MealFilterPresenterContract {
}
// MARK: - ...  Example of network response
extension MealFilterPresenter {
    func fetchResponse<T: MealFilterModel>(response: NetworkResponse<T>) {
        switch response {
            case .success(_):
                break
            case .failure(_):
                break
        }
    }
}
