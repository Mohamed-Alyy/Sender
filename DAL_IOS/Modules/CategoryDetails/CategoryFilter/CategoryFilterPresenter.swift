//
//  CategoryFilterPresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/20/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class CategoryFilterPresenter: BasePresenter<CategoryFilterViewContract> {
}
// MARK: - ...  Presenter Contract
extension CategoryFilterPresenter: CategoryFilterPresenterContract {
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
