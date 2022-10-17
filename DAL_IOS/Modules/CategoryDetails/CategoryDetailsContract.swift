//
//  CategoryDetailsContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/19/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol CategoryDetailsPresenterContract: PresenterProtocol {
    func fetchProviders()
}
// MARK: - ...  View Contract
protocol CategoryDetailsViewContract: PresentingViewProtocol {
    func didFetchProviders(for list: [Provider]?)
    func didFetchFilter(for model: FilterOptionModel.DataClass?)
}
// MARK: - ...  Router Contract
protocol CategoryDetailsRouterContract: Router, RouterProtocol {
    func provider(for provider: Provider?)
    func filter()
}
