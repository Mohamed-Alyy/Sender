//
//  LoginPresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class LoginPresenter: BasePresenter<LoginViewContract> {
}
// MARK: - ...  Presenter Contract
extension LoginPresenter: LoginPresenterContract {
    func login() {
        guard let view = view as? LoginVC else { return }
        if !view.validate(txfs: [view.mobileTxf, view.passwordTxf]) {
            return
        }
        if view.mobileTxf.text?.count ?? 0 != 9 {
            view.didError(error: "The mobile number must be 9 digits".localized)
            return
        }
        view.startLoading()
        NetworkManager.instance.paramaters["phone"] = view.mobileTxf.text
        NetworkManager.instance.paramaters["password"] = view.passwordTxf.text
        NetworkManager.instance.paramaters["device_token"] = Constants.FCMTOKEN
        NetworkManager.instance.paramaters["device_type"] = "ios"
        NetworkManager.instance.request(.login, type: .post, UserRoot.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    model?.save()
                    self?.view?.didLogin()
                case .failure(let error):
                    self?.view?.didError(error: error?.localizedDescription)
            }
        }
    }
}
