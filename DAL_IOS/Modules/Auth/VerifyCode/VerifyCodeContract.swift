//
//  VerifyCodeContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol VerifyCodePresenterContract: PresenterProtocol {
    func resendCode(mobile: String?)
    func verifyCode(mobile: String?, code: Int?)
    func verifyCodeForgotPassword(user_id: Int?, code: Int?)
}
// MARK: - ...  View Contract
protocol VerifyCodeViewContract: PresentingViewProtocol {
    func didResend(code: Int?)
    func didVerify(secret_code: String)
    func didError(error: String?)
}
// MARK: - ...  Router Contract
protocol VerifyCodeRouterContract: Router, RouterProtocol {
    func resetPassword(secret_code: String)
    func completeRegister()
}
