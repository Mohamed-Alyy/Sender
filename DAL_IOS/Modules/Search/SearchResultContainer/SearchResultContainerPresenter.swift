//
//  SearchResultContainerPresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/18/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class SearchResultContainerPresenter: BasePresenter<SearchResultContainerViewContract> {
    var options: [String: Any] = [:]
}
// MARK: - ...  Presenter Contract
extension SearchResultContainerPresenter: SearchResultContainerPresenterContract {
    func search() {
        for option in options {
            NetworkManager.instance.paramaters[option.key] = option.value
        }
        NetworkManager.instance.request(.providers, type: .get, CategoryDetailsModel.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    self?.view?.didSearch(for: model?.data)
                case .failure:
                    break
            }
        }
    }
}
