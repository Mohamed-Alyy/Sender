//
//  HomePresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/29/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class HomePresenter: BasePresenter<HomeViewContract> {
  var dispatchGroup = DispatchGroup()
}
// MARK: - ...  Presenter Contract
extension HomePresenter: HomePresenterContract {
    func fetchHome() {
        view?.startLoading()
        fetchCategories()
        fetchAds()
        fetchSuggestedProducts()
        dispatchGroupNotify()
    }
    
    private func dispatchGroupNotify(){
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else {return}
            self.view?.stopLoading()
            print("dispatchGroup.notify ")
        }
    }
    
    func fetchCategories() {
        dispatchGroup.enter()
        NetworkManager.instance.request(.providerCategories, type: .get, CategoriesModel.self) { [weak self] (response) in
            defer {self?.dispatchGroup.leave() }
            switch response {
                case .success(let model):
                    self?.view?.didFetchCategories(model: model?.data)
                case .failure:
                    break
            }
        }
    }
    
    func fetchAds() {
        dispatchGroup.enter()
        NetworkManager.instance.request(.ads, type: .get, AdsModel.self) { [weak self] (response) in
            defer {self?.dispatchGroup.leave() }
            switch response {
                case .success(let model):
                    self?.view?.didFetchAds(model: model?.data)
                case .failure:
                    break
            }
        }
    }
    
    func fetchSuggestedProducts() {
        dispatchGroup.enter()
        NetworkManager.instance.request(.suggestedProducts, type: .get, ProviderCategoriesMealsModel.self) { [weak self] (response) in
            defer {self?.dispatchGroup.leave() }
            switch response {
                case .success(let model):
                self?.view?.didFetchSuggestedProducts(model: model?.data)
                case .failure:
                    break
            }
        }
    }
    
    
    
    func fetchUser() {
        NetworkManager.instance.request(.profile, type: .get, UserRoot.self) { [weak self] (response) in
            self?.view?.stopLoading()
            switch response {
            case .success(let model):
                model?.save()
                self?.view?.didFetchUser()
            case .failure(_):
                break
            }
        }
    }
}
