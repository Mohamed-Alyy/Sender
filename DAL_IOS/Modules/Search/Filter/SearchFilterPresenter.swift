//
//  SearchFilterPresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/19/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class SearchFilterPresenter: BasePresenter<SearchFilterViewContract> {
    var dispatchGroup = DispatchGroup()
}
// MARK: - ...  Presenter Contract
extension SearchFilterPresenter: SearchFilterPresenterContract {
    
    func fetchLookup() {
        view?.startLoading()
        fetchCategories()
        fetchMenuCategories()
        fetchAreas()
        dispatchGroupNotify()
    }
    
    private func dispatchGroupNotify(){
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else {return}
            self.view?.stopLoading()
            self.view?.reloadFilterView()
            print("dispatchGroup.notify ")
        }
    }
}
// MARK: - ...  Example of network response
extension SearchFilterPresenter {
    func fetchResponse<T: SearchFilterModel>(response: NetworkResponse<T>) {
        switch response {
            case .success(_):
                break
            case .failure(_):
                break
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
    
    func fetchMenuCategories() {
        dispatchGroup.enter()
        NetworkManager.instance.request(.menuCategories, type: .get, CategoriesModel.self) { [weak self] (response) in
            defer {self?.dispatchGroup.leave() }
            switch response {
                case .success(let model):
                    self?.view?.didFetchMenuCategories(model: model?.data)
                case .failure:
                    break
            }
        }
    }
    
    func fetchAreas() {
        dispatchGroup.enter()
        NetworkManager.instance.request(.areas, type: .get, AreasModel.self) { [weak self] (response) in
            defer {self?.dispatchGroup.leave() }
            switch response {
                case .success(let model):
                    self?.view?.didFetchAreas(model: model?.data)
                var cities: [CitiesListModel] = []
                for city in model?.data ?? [] {
                    let areaCity = city.cities
                    cities.append(contentsOf: areaCity ?? [])
                }
                self?.view?.didFetchCities(model: cities)
                case .failure:
                    break
            }
        }
    }
    
    func fetchCities(areasId: Int) {
        guard let view = view as? SearchFilterVC else { return }
        view.startLoading()
        let method = NetworkConfigration.EndPoint.endPoint(point: .areas, paramters: [areasId, "cities"])
        NetworkManager.instance.request(method, type: .get, CitiesListByIdModel.self) { [weak self] (response) in
            defer {self?.view?.stopLoading() }
            switch response {
                case .success(let model):
                    self?.view?.didFetchCities(model: model?.data)
                case .failure:
                    break
            }
        }
    }
}
