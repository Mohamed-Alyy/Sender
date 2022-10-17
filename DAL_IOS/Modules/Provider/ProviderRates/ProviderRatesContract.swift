//
//  ProviderRatesContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/24/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol ProviderRatesPresenterContract: PresenterProtocol {
    func fetchRates(for provider: Int?)
}
// MARK: - ...  View Contract
protocol ProviderRatesViewContract: PresentingViewProtocol {
    func didFetchRates(for list: [Provider.Rate]?)
}
// MARK: - ...  Router Contract
protocol ProviderRatesRouterContract: Router, RouterProtocol {
}
