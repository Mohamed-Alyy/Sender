//
//  CategoryFilterContract.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/20/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol CategoryFilterPresenterContract: PresenterProtocol {
    func fetchFilter()
}
// MARK: - ...  View Contract
protocol CategoryFilterViewContract: PresentingViewProtocol {
    func didFetchFilter(for model: FilterOptionModel.DataClass?)
}
// MARK: - ...  Router Contract
protocol CategoryFilterRouterContract: Router, RouterProtocol {
    func didFilter(paramters: [String: Any]?)
}

protocol CategoryFilterDelegate: class {
    func categoryFilter(_ delegate: CategoryFilterDelegate?, for options: [String: Any])
}
