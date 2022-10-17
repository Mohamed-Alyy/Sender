//
//  RegisterContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol RegisterPresenterContract: PresenterProtocol {
    func register(mobile: String?)
}
// MARK: - ...  View Contract
protocol RegisterViewContract: PresentingViewProtocol {
    func didRegister(code: Int?)
    func didError(error: String?)
}
// MARK: - ...  Router Contract
protocol RegisterRouterContract: Router, RouterProtocol {
    func verify(code: Int?)
}
