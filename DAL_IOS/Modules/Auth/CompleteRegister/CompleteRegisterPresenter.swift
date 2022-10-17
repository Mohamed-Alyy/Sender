//
//  CompleteRegisterPresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class CompleteRegisterPresenter: BasePresenter<CompleteRegisterViewContract> {
}
// MARK: - ...  Presenter Contract
extension CompleteRegisterPresenter: CompleteRegisterPresenterContract {
    func register() {
        guard let view = view as? CompleteRegisterVC else { return }
        if !view.validate(txfs: [view.nameTxf, view.emailTxf, view.passwordTxf, view.confirmPasswordTxf]) {
            return
        }
        if view.passwordTxf.text != view.confirmPasswordTxf.text {
            self.view?.didError(error: "Password doesn't match".localized)
            return
        }
        view.startLoading()
        NetworkManager.instance.paramaters["phone"] = view.mobile
        NetworkManager.instance.paramaters["email"] = view.emailTxf.text
        NetworkManager.instance.paramaters["name"] = view.nameTxf.text
        NetworkManager.instance.paramaters["password"] = view.passwordTxf.text
        NetworkManager.instance.paramaters["password_confirmation"] = view.confirmPasswordTxf.text
        NetworkManager.instance.paramaters["device_token"] = Constants.FCMTOKEN
        NetworkManager.instance.paramaters["device_type"] = "ios"
        NetworkManager.instance.request(.register, type: .post, UserRoot.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    model?.save()
                    self?.view?.didRegister()
                case .failure(let error):
                    self?.view?.didError(error: error?.localizedDescription)
            }
        }
    }
}
// MARK: - ...  Example of network response
extension CompleteRegisterPresenter {
    
}
