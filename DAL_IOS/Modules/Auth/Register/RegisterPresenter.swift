//
//  RegisterPresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class RegisterPresenter: BasePresenter<RegisterViewContract> {
}
// MARK: - ...  Presenter Contract
extension RegisterPresenter: RegisterPresenterContract {
    func register(mobile: String?) {
        if mobile == nil {
            view?.didError(error: "Mobile is required".localized)
            return
        }
        if mobile?.count ?? 0 != 9 {
            view?.didError(error: "The mobile number must be 9 digits".localized)
            return
        }
        NetworkManager.instance.paramaters["phone"] = mobile
        NetworkManager.instance.request(.sendCode, type: .post, BaseModel<String>.self) { [weak self] (response) in
            switch response {
                case .success( _):
                self?.view?.didRegister(code: Constants.code)
                case .failure(let error):
                    self?.view?.didError(error: error?.localizedDescription)
            }
        }
    }
}
