//
//  ProviderMealsVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/24/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ProviderMealsVC: BaseController {
    @IBOutlet weak var providerMenuCategoriesCollection: UICollectionView!
    @IBOutlet weak var itemsTbl: UITableView!
    
    var presenter: ProviderMealsPresenter?
    var router: ProviderMealsRouter?
    var provider: ProvidersResult?
    var categories: [ProviderCategoriesDatum]?
    var selectedCategory: ProviderCategoriesDatum?
    var meals: [ProviderCategoriesMealsDatum] = []
}

// MARK: - ...  LifeCycle
extension ProviderMealsVC {
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
        setup()
        fetch()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter = nil
        router = nil
    }
}
// MARK: - ...  Functions
extension ProviderMealsVC {
    func setup() {
        itemsTbl.delegate = self
        itemsTbl.dataSource = self
        providerMenuCategoriesCollection.delegate = self
        providerMenuCategoriesCollection.dataSource = self
        
    }
    
    func fetch() {
        guard let providerId = provider?.id else {return}
        startLoading()
        presenter?.fetchProducts(for: selectedCategory?.id, providerId: providerId)
    }
   
     
}

// MARK: - ...  View Contract
extension ProviderMealsVC: ProviderMealsViewContract {
    func didFetchProducts(for list: [ProviderCategoriesMealsDatum]?) {
        stopLoading()
        meals = list ?? []
        itemsTbl.reloadData()
//        meals.removeAll()
    }
}

extension ProviderMealsVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        categories?.forEach({$0.isSelected = false})
        let category = categories?.getElement(at: indexPath.row)
        category?.isSelected = true
        selectedCategory = category
        providerMenuCategoriesCollection.reloadData()
        fetch()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat = (categories?.getElement(at: indexPath.row)?.title?.width(withConstrainedHeight: 30, font: ThemeApp.Fonts.regularFont(size: 13)) ?? 50) + 13 + 16
        width = width < 50 ? 50 : width + 10
        return CGSize(width: width, height: 35)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cell(type: ProviderCategoriesCell.self, indexPath)
        let category = categories?.getElement(at: indexPath.row)
        cell.configuraCell(category?.title, isSelected: category?.isSelected)
        return cell
    }
}
extension ProviderMealsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: ProviderCategoriesMealCell.self, indexPath)
        cell.model = meals.getElement(at: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.meal(for: meals.getElement(at: indexPath.row))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}


 
