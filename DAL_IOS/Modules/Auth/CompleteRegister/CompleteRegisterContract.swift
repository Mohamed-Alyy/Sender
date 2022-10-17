//
//  CompleteRegisterContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol CompleteRegisterPresenterContract: PresenterProtocol {
    func register()
}
// MARK: - ...  View Contract
protocol CompleteRegisterViewContract: PresentingViewProtocol {
    func didRegister()
    func didError(error: String?)
}
// MARK: - ...  Router Contract
protocol CompleteRegisterRouterContract: Router, RouterProtocol {
    func terms()
    func home()
}
