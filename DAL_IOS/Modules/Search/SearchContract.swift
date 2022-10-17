//
//  SearchContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/18/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol SearchPresenterContract: PresenterProtocol {
    func fetchFilter()
}
// MARK: - ...  View Contract
protocol SearchViewContract: PresentingViewProtocol {
    func didFetchFilter(for model: FilterOptionModel.DataClass?)
}
// MARK: - ...  Router Contract
protocol SearchRouterContract: Router, RouterProtocol {
    func filter(with options: FilterOptionModel.DataClass?)
    func provider(for provider: Provider?)
}
