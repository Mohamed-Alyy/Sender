//
//  SearchCategoriesContract.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 19/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol SearchCategoriesPresenterContract: PresenterProtocol {
    func search()
}
// MARK: - ...  View Contract
protocol SearchCategoriesViewContract: PresentingViewProtocol {
    func didSearch(for list: [ProvidersResult]?)
}
// MARK: - ...  Router Contract
protocol SearchCategoriesRouterContract: Router, RouterProtocol {
    func filter(with options: FilterOptionModel.DataClass?)
    func provider(for provider: ProvidersResult?)
}
