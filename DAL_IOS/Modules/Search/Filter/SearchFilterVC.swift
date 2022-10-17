//
//  SearchFilterVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/19/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class SearchFilterVC: BaseController {
    @IBOutlet weak var resturantTypeView: FilterView!
    @IBOutlet weak var foodTypeView: FilterView!
    
    @IBOutlet weak var areaView: FilterView!
    @IBOutlet weak var citiesView: FilterView!
    
    var presenter: SearchFilterPresenter?
    var router: SearchFilterRouter?
    weak var delegate: SearchFilterDelegate?
    
    var paramters: [String: Any] = [:]
    var categories: [CategoriesResult]?
    var menuCategories: [CategoriesResult]?
    var areas: [AreasDatum]?
    var cities: [CitiesListModel]?
}

// MARK: - ...  LifeCycle
extension SearchFilterVC {
    override func viewDidLoad() {
        super.hideNav = true
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter = .init()
        presenter?.view = self
        router = .init()
        router?.view = self
        presenter?.fetchLookup()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter = nil
        router = nil
    }
}
// MARK: - ...  Functions
extension SearchFilterVC {
    func setup() {
        //placesView.isHidden = false
        resturantTypeView.onlyItemSelected = true
        foodTypeView.onlyItemSelected = true
        areaView.onlyItemSelected = true
        citiesView.onlyItemSelected = true
        
        resturantTypeView.dataSource = self
        resturantTypeView.delegate = self
        foodTypeView.dataSource = self
        foodTypeView.delegate = self
        areaView.dataSource = self
        areaView.delegate = self
        citiesView.dataSource = self
        areaView.delegate = self
    }
    func setupDeliveryFilters() -> [FilterModel] {
        var array: [FilterOptionModel.Feature] = []
        let model = FilterOptionModel.Feature.init(id: 0, name: "All".localized, active: 1, checked: false)
        let model1 = FilterOptionModel.Feature.init(id: 1, name: "Support delivery".localized, active: 1, checked: false)
        let model2 = FilterOptionModel.Feature.init(id: 2, name: "Not support delivery".localized, active: 1, checked: false)
        array.append(contentsOf: [model, model1, model2])
        return array
    }
    func setupReservationFilters() -> [FilterModel] {
        var array: [FilterOptionModel.Feature] = []
        let model = FilterOptionModel.Feature.init(id: 0, name: "All".localized, active: 1, checked: false)
        let model1 = FilterOptionModel.Feature.init(id: 1, name: "Support reservation".localized, active: 1, checked: false)
        let model2 = FilterOptionModel.Feature.init(id: 2, name: "Not support reservation".localized, active: 1, checked: false)
        array.append(contentsOf: [model, model1, model2])
        return array
    }
}

extension SearchFilterVC {
    override func backBtn(_ sender: Any) {
        router?.didFilter()
    }
    
    @IBAction func didTappedCancel(_ sender: UIButton){
        self.dismiss(animated: false)
    }
    
    @IBAction func apply(_ sender: Any) {
        if let resturant = resturantTypeView.selectedItemsTags.first?.id {
            paramters["category_id"] = resturant
        }
        if let food = foodTypeView.selectedItemsTags.first?.id {
            paramters["menu_category_id"] = food
        }
        
        if let distance = areaView.selectedItemsTags.first?.id {
            paramters["area_id"] = distance
        }
        if let place = citiesView.selectedItemsTags.first?.id {
            paramters["city_id"] = place
        }
        router?.didFilter(paramters: paramters)
    }
}
// MARK: - ...  View Contract
extension SearchFilterVC: SearchFilterViewContract {
    func didFetchCategories(model: [CategoriesResult]?) {
        categories = model
        let model = CategoriesResult(id: 0, checked: false, title: "All".localized, image: nil, providers_count: nil)
        categories?.insert(model, at: 0)
        resturantTypeView.reload()
    }
    
    func didFetchMenuCategories(model: [CategoriesResult]?) {
        menuCategories = model
        let model = CategoriesResult(id: 0, checked: false, title: "All".localized, image: nil, providers_count: nil)
        menuCategories?.insert(model, at: 0)
        foodTypeView.reload()
    }
    
    func didFetchAreas(model: [AreasDatum]?) {
        areas = model
        let model = AreasDatum(checked: false, id: 0, title: "All".localized, name: "All".localized, cities: nil, lang: nil)
        areas?.insert(model, at: 0)
        areaView.reload()
    }
    
    func didFetchCities(model: [CitiesListModel]?) {
        cities?.removeAll()
        cities = model
        let model = CitiesListModel(checked: false, id: 0, title: "All".localized, name: "All".localized, lang: nil)
        cities?.insert(model, at: 0)
        citiesView.reload()
    }
    
    func reloadFilterView() {
        setup()
    }
    
}

extension SearchFilterVC: FilterViewDataSource,FilterViewDelegate {
    func filterView(for filter: FilterView?) -> [FilterModel] {
        switch filter {
            case resturantTypeView:
            return categories ?? []
            case foodTypeView:
                return menuCategories ?? []
            case areaView:
                return areas ?? []
            case citiesView:
                return cities ?? []
            default:
                return []
        }
    }
    
    func filterView(for filter: FilterView?, at didSelectItem: Int) {
        if filter == areaView {
            guard let id = areas?.getElement(at: didSelectItem)?.id else {return}
            presenter?.fetchCities(areasId: id)
            citiesView.selectedItemsTags = []
            citiesView.selectedItemsPaths = []
        }
    }
}
