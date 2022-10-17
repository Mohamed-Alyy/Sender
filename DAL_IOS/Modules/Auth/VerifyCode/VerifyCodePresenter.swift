//
//  VerifyCodePresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class VerifyCodePresenter: BasePresenter<VerifyCodeViewContract> {

    func verifyCode(mobile: String?, code: Int?) {
        NetworkManager.instance.paramaters["phone"] = mobile
        NetworkManager.instance.paramaters["code"] = code
        NetworkManager.instance.request(.checkCode, type: .post, VerifyCodeModel.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                self?.view?.didVerify(secret_code: "")
                case .failure(let error):
                    self?.view?.didError(error: error?.localizedDescription)
            }
        }
    }
    
    func verifyCodeForgotPassword(user_id: Int?, code: Int?) {
        NetworkManager.instance.paramaters["user_id"] = user_id
        NetworkManager.instance.paramaters["code"] = code
        NetworkManager.instance.request(.forgotPasswordStep2, type: .post, VerifyCodeResetPasswordModel.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                guard let secretCode = model?.secret_code else {
                    self?.view?.didError(error: model?.message ?? "")
                    return}
                self?.view?.didVerify(secret_code: secretCode)
                case .failure(let error):
                    self?.view?.didError(error: error?.localizedDescription)
            }
        }
    }
    
    func resendCode(mobile: String?) {
        NetworkManager.instance.paramaters["phone"] = mobile
        NetworkManager.instance.request(.sendCode, type: .post, BaseModel<Int>.self) { [weak self] (response) in
            switch response {
                case .success(_):
                self?.view?.didResend(code: Constants.code)
                case .failure(let error):
                    self?.view?.didError(error: error?.localizedDescription)
            }
        }
    }
}
// MARK: - ...  Presenter Contract
extension VerifyCodePresenter: VerifyCodePresenterContract {
}
 
