//
//  EditProfileContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol EditProfilePresenterContract: PresenterProtocol {
    func update()
    func deleteAccount()
}
// MARK: - ...  View Contract
protocol EditProfileViewContract: PresentingViewProtocol {
    func didSuccess(withUser id: Int)
    func didDeleteSuccess(message: String)
    func didFail(error: String?)
}
// MARK: - ...  Router Contract
protocol EditProfileRouterContract: Router, RouterProtocol {
    func openMap()
    func profile()
}
