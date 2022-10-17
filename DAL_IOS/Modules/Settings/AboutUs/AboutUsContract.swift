//
//  AboutUsContract.swift
//  DAL_Provider
//
//  Created by Mabdu on 02/03/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol AboutUsPresenterContract: PresenterProtocol {
    func settings()
}
// MARK: - ...  View Contract
protocol AboutUsViewContract: PresentingViewProtocol {
    func didFetch(for setting: AboutModel?)
}
// MARK: - ...  Router Contract
protocol AboutUsRouterContract: Router, RouterProtocol {
}
