//
//  FavoritesPresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class FavoritesPresenter: BasePresenter<FavoritesViewContract> {
}
// MARK: - ...  Presenter Contract
extension FavoritesPresenter: FavoritesPresenterContract {
    func fetchFavorites() {
        self.view?.startLoading()
        NetworkManager.instance.request(.favorites, type: .get, ProvidersModel.self) { [weak self] (response) in
            guard let self = self else {return}
            defer {self.view?.stopLoading()}
            switch response {
                case .success(let model):
                    self.view?.didFetch(for: model?.data)
                case .failure:
                    break
            }
        }
    }
}

