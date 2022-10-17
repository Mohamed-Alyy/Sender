//
//  SearchResultContainerContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/18/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol SearchResultContainerPresenterContract: PresenterProtocol {
    func search()
}
// MARK: - ...  View Contract
protocol SearchResultContainerViewContract: PresentingViewProtocol {
    func didSearch(for list: [Provider]?)
}
// MARK: - ...  Router Contract
protocol SearchResultContainerRouterContract: Router, RouterProtocol {
}
