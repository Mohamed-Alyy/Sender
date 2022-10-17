//
//  LangIntroPresenter.swift
//  DAL_Provider
//
//  Created by Mabdu on 03/03/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class LangIntroPresenter: BasePresenter<LangIntroViewContract> {
}
// MARK: - ...  Presenter Contract
extension LangIntroPresenter: LangIntroPresenterContract {
}
// MARK: - ...  Example of network response
extension LangIntroPresenter {
    func fetchResponse<T: LangIntroModel>(response: NetworkResponse<T>) {
        switch response {
            case .success(_):
                break
            case .failure(_):
                break
        }
    }
}
