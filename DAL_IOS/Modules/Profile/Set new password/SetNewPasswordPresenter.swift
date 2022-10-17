//
//  SetNewPasswordPresenter.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 02/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation

class SetNewPasswordPresenter: BasePresenter<SetNewPasswordViewContract> {
}
// MARK: - ...  Presenter Contract
extension SetNewPasswordPresenter: SetNewPasswordContract {
    func resetPassword() {
        guard let view = view as? SetNewPasswordVC else { return }
        if !view.validate(txfs: [view.oldPasswordTxf, view.newPasswordTxf,view.confirmNewPasswordTxf]) {
            return
        }
        if view.newPasswordTxf.text != view.confirmNewPasswordTxf.text {
            self.view?.didError(error: "Password doesn't match".localized)
            return
        }
        view.startLoading()
        NetworkManager.instance.paramaters["old_password"] = view.oldPasswordTxf.text
        NetworkManager.instance.paramaters["new_password"] = view.newPasswordTxf.text
        NetworkManager.instance.paramaters["new_password_confirmation"] = view.confirmNewPasswordTxf.text
        NetworkManager.instance.request(.changePassword, type: .post, BaseModel<String>.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    self?.view?.didReset(message: model?.message)
                case .failure(let error):
                    self?.view?.didError(error: error?.localizedDescription)
            }
        }
    }
}
