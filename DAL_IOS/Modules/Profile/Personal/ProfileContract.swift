//
//  ProfileContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol ProfilePresenterContract: PresenterProtocol {
    func fetch()
}
// MARK: - ...  View Contract
protocol ProfileViewContract: PresentingViewProtocol {
    func didFetch()
}
// MARK: - ...  Router Contract
protocol ProfileRouterContract: Router, RouterProtocol {
    func editProfile()
    func favorites()
    func reservations()
    func logout()
}
