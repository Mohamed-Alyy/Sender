//
//  SetNewPasswordContract.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 02/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation
protocol SetNewPasswordContract: PresenterProtocol {
    func resetPassword()
}
// MARK: - ...  View Contract
protocol SetNewPasswordViewContract: PresentingViewProtocol {
    func didReset(message: String?)
    func didError(error: String?)
}
// MARK: - ...  Router Contract
protocol SetNewPasswordRouterContract: Router, RouterProtocol {
    func login()
}
