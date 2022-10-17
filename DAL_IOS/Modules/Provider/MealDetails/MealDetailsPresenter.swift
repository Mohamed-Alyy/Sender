//
//  MealDetailsPresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/25/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class MealDetailsPresenter: BasePresenter<MealDetailsViewContract> {
}
// MARK: - ...  Presenter Contract
extension MealDetailsPresenter: MealDetailsPresenterContract {
    func fetchMeal(mealID: Int?) {
        let method = NetworkConfigration.EndPoint.endPoint(point: .products, paramters: [mealID ?? 0])
        NetworkManager.instance.request(method, type: .get, ProviderCategoriesMealsDetailsModel.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    self?.view?.didFetchMeal(for: model?.data)
                case .failure:
                    self?.view?.stopLoading()

            }
        }
    }
}
