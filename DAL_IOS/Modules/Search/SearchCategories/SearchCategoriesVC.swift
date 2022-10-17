//
//  SearchCategoriesVC.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 19/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

class SearchCategoriesVC: BaseController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var searchTxf: UITextField!
    @IBOutlet weak var resturantsTbl: UITableView!
    @IBOutlet weak var sortButton: UIButton!
    var presenter: SearchCategoriesPresenter?
    var router: SearchCategoriesRouter?
    var filterOptions: FilterOptionModel.DataClass?
    var text: String?
    var options: [String: Any] = [:]
    var category: CategoriesResult?
    var providers: [ProvidersResult] = []
    var sortModel: [SortModel] = [SortModel(title: "Nearby".localized, key: "distance"),SortModel(title: "Lowest Delivery Price".localized, key: "km_price"),SortModel(title: "Best Seller".localized, key: "top_sales"),SortModel(title: "Top Rated".localized, key: "top_rated")] 
}

// MARK: - ...  LifeCycle
extension SearchCategoriesVC {
    override func viewDidLoad() {
        super.hideNav = true
        super.viewDidLoad()
        presenter = .init()
        presenter?.view = self
        router = .init()
        router?.view = self
        setup()
        setupSearchView()
        router?.openMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.search()
    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        presenter = nil
//        router = nil
//    }
}

// MARK: - ...  Functions
extension SearchCategoriesVC {
    func setup() {
        resturantsTbl.delegate = self
        resturantsTbl.dataSource = self
        let categoryTitle = category == nil ? "Search".localized : category?.title
        titleLbl.text = categoryTitle
        options["category_id"] = category?.id
        let item = sortModel.getElement(at: 0)
        sortButton.setTitle(item?.title, for: .normal)
        options["sort_by"] = item?.key
        
    }
    
    func setupSearchView() {
        searchTxf.text = text
        searchTxf.delegate = self
        if text?.count ?? 0 >= 1 || category != nil {
            self.search()
        }
    }
    
    func search() {
        options["search_term"] = text == nil ? searchTxf.text : text
        presenter?.search()
    }
}
extension SearchCategoriesVC: UITableViewDelegate, UITableViewDataSource {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == resturantsTbl {
//            if self.presenter?.canPaginate() == true {
//                resturantsTbl.swipeButtomRefresh { [weak self] in
//                    self?.presenter?.search()
//                }
//            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return providers.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: SearchCategoriesRestaurantCell.self, indexPath)
        cell.model = providers.getElement(at:indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.provider(for: providers.getElement(at: indexPath.row))
    }
}

extension SearchCategoriesVC {
    @IBAction func filter(_ sender: Any) {
        router?.filter(with: filterOptions)
    }
    
    @IBAction func didTappedSearch(_ sender: Any) {
        if (searchTxf.text?.count ?? 0) >= 1 {
            self.search()
        }
    }
    
    @IBAction func didTappedSort(_ sender: UIButton){
        guard let scene = R.storyboard.pickerViewHelper.pickerController() else { return }
        scene.source = sortModel
        scene.titleClosure = { [weak self] row in
            return self?.sortModel.getElement(at: row)?.title
        }
        scene.didSelectClosure = { [weak self] row in
            let item = self?.sortModel.getElement(at: row)
            self?.sortButton.setTitle(item?.title, for: .normal)
            self?.options["sort_by"] = item?.key
            self?.search()
        }
        pushPop(scene)
    }
}
// MARK: - ...  View Contract
extension SearchCategoriesVC: SearchCategoriesViewContract {
    func didSearch(for list: [ProvidersResult]?) {
        stopLoading()
        providers = list ?? []
        resturantsTbl.reloadData()
    }
    
    func didFetchFilter(for model: FilterOptionModel.DataClass?) {
        filterOptions = model
        NotificationCenter.default.post(name: Notification.Name("NEW_SEARCH"), object: nil, userInfo: ["tags": filterOptions?.products ?? []])

    }
}

extension SearchCategoriesVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.count ?? 0 > 0 {
            SearchHistory().save(text: textField.text)
            text = textField.text
            setupSearchView()
        }
    }
}

extension SearchCategoriesVC: SearchFilterDelegate {
    func searchFilter(_ filter: SearchFilterDelegate?, for options: [String : Any]) {
        var filter = options
        if text != nil {
            filter["name"] = text
        }
        self.options = filter
        presenter?.search()
    }
}

extension SearchCategoriesVC: LocationFromMapDelegateContract {
    func saveLocation(lat: Double?, lng: Double?, address: String?) {
        presenter?.headers["Lat"] = "\(lat ?? 0)"
        presenter?.headers["Lng"] = "\(lng ?? 0)"
        presenter?.search()
    }
    func didFailLocation() {
        
    }
}
