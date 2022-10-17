//
//  ResetPasswordContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol ResetPasswordPresenterContract: PresenterProtocol {
    func resetPassword()
}
// MARK: - ...  View Contract
protocol ResetPasswordViewContract: PresentingViewProtocol {
    func didReset(message: String?)
    func didError(error: String?)
}
// MARK: - ...  Router Contract
protocol ResetPasswordRouterContract: Router, RouterProtocol {
    func login()
}
