//
//  SearchCategoriesPresenter.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 19/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation

class SearchCategoriesPresenter: BasePresenter<SearchCategoriesViewContract> {
    var headers: [String: String] = [:]
}
// MARK: - ...  Presenter Contract
extension SearchCategoriesPresenter: SearchCategoriesPresenterContract { 
    
    func search() {
        guard let view = view as? SearchCategoriesVC else { return }
        view.startLoading()
        for (key, value) in headers {
            NetworkManager.instance.headers[key] = value
        }
        
        for option in view.options {
            NetworkManager.instance.paramaters[option.key] = option.value
        }
        NetworkManager.instance.request(.providers, type: .get, ProvidersModel.self) { [weak self] (response) in
            defer {view.stopLoading()}
            switch response {
                case .success(let model):
                    self?.view?.didSearch(for: model?.data)
                case .failure:
                    break
            }
        }
    }
}
