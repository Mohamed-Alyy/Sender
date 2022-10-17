//
//  LoginContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol LoginPresenterContract: PresenterProtocol {
    func login()
}
// MARK: - ...  View Contract
protocol LoginViewContract: PresentingViewProtocol {
    func didLogin()
    func didError(error: String?)
}
// MARK: - ...  Router Contract
protocol LoginRouterContract: Router, RouterProtocol {
    func forgetPassword()
    func register()
    func skip()
}
