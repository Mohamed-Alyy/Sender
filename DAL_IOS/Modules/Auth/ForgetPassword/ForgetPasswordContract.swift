//
//  ForgetPasswordContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol ForgetPasswordPresenterContract: PresenterProtocol {
    func sendCode(mobile: String?)
}
// MARK: - ...  View Contract
protocol ForgetPasswordViewContract: PresentingViewProtocol {
    func didSend(code: Int?, userId: Int)
    func didError(error: String?)
}
// MARK: - ...  Router Contract
protocol ForgetPasswordRouterContract: Router, RouterProtocol {
    func verify(code: Int?,userId: Int)
}
