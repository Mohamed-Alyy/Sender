//
//  ForgetPasswordPresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class ForgetPasswordPresenter: BasePresenter<ForgetPasswordViewContract> {
}
// MARK: - ...  Presenter Contract
extension ForgetPasswordPresenter: ForgetPasswordPresenterContract {
    func sendCode(mobile: String?) {
        if mobile == nil {
            view?.didError(error: "Mobile is required".localized)
            return
        }
        if mobile?.count ?? 0 != 9 {
            view?.didError(error: "The mobile number must be 9 digits".localized)
            return
        }
        NetworkManager.instance.paramaters["phone"] = mobile
        NetworkManager.instance.request(.forgotPasswordStep1, type: .get, ForgetPasswordModel.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                guard let userId = model?.user_id else {
                    self?.view?.didError(error: model?.message ?? "")
                    return
                }
                self?.view?.didSend(code: Constants.code, userId: userId)
                case .failure(let error):
                    self?.view?.didError(error: error?.localizedDescription)
            }
        }
    }
}
// MARK: - ...  Example of network response
extension ForgetPasswordPresenter {

}
