//
//  ResetPasswordPresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class ResetPasswordPresenter: BasePresenter<ResetPasswordViewContract> {
}
// MARK: - ...  Presenter Contract
extension ResetPasswordPresenter: ResetPasswordPresenterContract {
    func resetPassword() {
        guard let view = view as? ResetPasswordVC else { return }
        if !view.validate(txfs: [view.passwordTxf, view.confirmPasswordTxf]) {
            return
        }
        if view.passwordTxf.text != view.confirmPasswordTxf.text {
            self.view?.didError(error: "Password doesn't match".localized)
            return
        }
        view.startLoading()
        NetworkManager.instance.paramaters["secret_code"] = view.secret_code
        NetworkManager.instance.paramaters["new_password"] = view.passwordTxf.text
        NetworkManager.instance.paramaters["user_id"] = view.userId
        NetworkManager.instance.request(.saveResetPassword, type: .post, BaseModel<String>.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    self?.view?.didReset(message: model?.message)
                case .failure(let error):
                    self?.view?.didError(error: error?.localizedDescription)
            }
        }
    }
}
