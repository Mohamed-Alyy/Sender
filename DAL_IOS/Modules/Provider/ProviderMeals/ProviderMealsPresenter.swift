//
//  ProviderMealsPresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/24/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class ProviderMealsPresenter: BasePresenter<ProviderMealsViewContract> {
    var options: [String: Any] = [:]
}
// MARK: - ...  Presenter Contract
extension ProviderMealsPresenter: ProviderMealsPresenterContract {
    func fetchProducts(for menuCategoryId: Int?,providerId: Int?) {
        NetworkManager.instance.paramaters["menu_category_id"] = menuCategoryId
        NetworkManager.instance.paramaters["provider_id"] = providerId
        NetworkManager.instance.request(.products, type: .get, ProviderCategoriesMealsModel.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    self?.view?.didFetchProducts(for: model?.data)
                case .failure:
                    break
            }
        }
    }
}
