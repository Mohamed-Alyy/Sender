//
//  ProviderDetailsPresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/21/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class ProviderDetailsPresenter: BasePresenter<ProviderDetailsViewContract> {
}
// MARK: - ...  Presenter Contract
extension ProviderDetailsPresenter: ProviderDetailsPresenterContract {
}
// MARK: - ...  Example of network response
extension ProviderDetailsPresenter {
    func fetchCategories(categoryId: Int) {
        let method = NetworkConfigration.EndPoint.endPoint(point: .providers, paramters: [categoryId,"categories"])
        NetworkManager.instance.request(method, type: .get, ProviderCategoriesModel.self) { [weak self] (response) in
            defer {
                self?.fetchRates(providerId: categoryId)
            } 
            switch response {
            case .success(let model):
                self?.view?.didFetchCategories(model: model?.data)
            case .failure(_):
                break
            }
        }
    }
    
    func fetchRates(providerId: Int) {
        NetworkManager.instance.paramaters["provider_id"] = providerId
        NetworkManager.instance.request(.providerRatings, type: .get, ProviderRatingsModel.self) { [weak self] (response) in
            defer {self?.view?.stopLoading()}
            switch response {
            case .success(let model):
                self?.view?.didFetchRates(model: model?.data)
            case .failure(_):
                break
            }
        }
    }
}
