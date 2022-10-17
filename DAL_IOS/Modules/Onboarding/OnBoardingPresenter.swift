//
//  OnBoardingPresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class OnBoardingPresenter: BasePresenter<OnBoardingViewContract> {
}
// MARK: - ...  Presenter Contract
extension OnBoardingPresenter: OnBoardingPresenterContract {
}
// MARK: - ...  Example of network response
extension OnBoardingPresenter {
    func fetchResponse<T: OnBoardingModel>(response: NetworkResponse<T>) {
        switch response {
            case .success(_):
                break
            case .failure(_):
                break
        }
    }
}
