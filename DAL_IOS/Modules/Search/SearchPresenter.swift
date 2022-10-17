//
//  SearchPresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/18/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class SearchPresenter: BasePresenter<SearchViewContract> {
}
// MARK: - ...  Presenter Contract
extension SearchPresenter: SearchPresenterContract {
    func fetchFilter() {
        NetworkManager.instance.request(.providers, type: .get, FilterOptionModel.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    self?.view?.didFetchFilter(for: model?.data)
                case .failure:
                    break
            }
        }
    }
}

