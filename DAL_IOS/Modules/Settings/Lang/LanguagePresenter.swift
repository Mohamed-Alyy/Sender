//
//  LanguagePresenter.swift
//  DAL_IOS
//
//  Created by Mabdu on 17/02/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class LanguagePresenter: BasePresenter<LanguageViewContract> {
}
// MARK: - ...  Presenter Contract
extension LanguagePresenter: LanguagePresenterContract {
}
// MARK: - ...  Example of network response
extension LanguagePresenter {
    func fetchResponse<T: LanguageModel>(response: NetworkResponse<T>) {
        switch response {
            case .success(_):
                break
            case .failure(_):
                break
        }
    }
}
