//
//  CategoryDetailsPresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/19/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class CategoryDetailsPresenter: BasePresenter<CategoryDetailsViewContract> {
    var options: [String: Any] = [:]
}
// MARK: - ...  Presenter Contract
extension CategoryDetailsPresenter: CategoryDetailsPresenterContract {
    func fetchProviders() {
        for option in options {
            NetworkManager.instance.paramaters[option.key] = option.value
        }
        NetworkManager.instance.request(.providers, type: .get, CategoryDetailsModel.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    self?.paginator(respnod: model?.data)
                    self?.view?.didFetchProviders(for: model?.data)
                case .failure:
                    break
            }
        }
    }
    func fetchFilter() {
        NetworkManager.instance.request(.filterOptions, type: .get, FilterOptionModel.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    self?.view?.didFetchFilter(for: model?.data)
                case .failure:
                    break
            }
        }
    }
}

