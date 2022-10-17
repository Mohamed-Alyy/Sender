//
//  SearchVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/18/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class SearchVC: BaseController {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var searchTxf: UITextField!
    @IBOutlet weak var miceBtn: UIButton!
    @IBOutlet weak var newSearchContainer: UIView!
    @IBOutlet weak var searchResultContainer: UIView!
    var presenter: SearchPresenter?
    var router: SearchRouter?
    var filterOptions: FilterOptionModel.DataClass?
    var providers: [Provider] = []
    var text: String?
    var options: [String: Any] = [:]
    var category: CategoriesResult?
}

// MARK: - ...  LifeCycle
extension SearchVC {
    override func viewDidLoad() {
        super.hideNav = true
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter = .init()
        presenter?.view = self
        router = .init()
        router?.view = self
        setupSearchView()
        setupNotifications()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter = nil
        router = nil
    }
}
// MARK: - ...  Functions
extension SearchVC {
    func setup() {
        let categoryTitle = category == nil ? "Search".localized : category?.title
        titleLbl.text = categoryTitle
        options["category_id"] = category?.id
        presenter?.fetchFilter()
        newSearchContainer.isHidden = false
        searchResultContainer.isHidden = true
        router?.openMap()
    }
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("SELECT_TEXT"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("SELECT_PROVIDER"), object: nil)

    }
    func setupSearchView() {
        searchTxf.text = text
        searchTxf.delegate = self
        if text?.count ?? 0 >= 1 || category != nil {
            miceBtn.setImage(#imageLiteral(resourceName: "Icon material-cancel"), for: .normal)
            UIView.animate(withDuration: 0.5) {
                self.newSearchContainer.isHidden = true
                self.searchResultContainer.isHidden = false
                self.search()
            }
        } else {
            miceBtn.setImage(#imageLiteral(resourceName: "microphone-black-shape-1"), for: .normal)
            UIView.animate(withDuration: 0.5) {
                self.newSearchContainer.isHidden = false
                self.searchResultContainer.isHidden = true
            }
        }
    }
    func search() {
        options["search_term"] = text
        DispatchQueue.main.asyncAfter(deadline: .now()+0.50) {
            NotificationCenter.default.post(name: Notification.Name("OPTIONS_SEARCH"), object: nil, userInfo: ["options": self.options])
        }
    }
    @objc func methodOfReceivedNotification(notification: Notification) {
        if notification.name == Notification.Name("SELECT_TEXT") {
            let text = notification.userInfo?["text"] as? String
            self.text = text
            self.setupSearchView()
        } else if notification.name == Notification.Name("SELECT_PROVIDER") {
            let provider = notification.userInfo?["provider"] as? Provider
            router?.provider(for: provider)
        }
    }
}

extension SearchVC: LocationFromMapDelegateContract {
    func saveLocation(lat: Double?, lng: Double?, address: String?) {
        options["lat"] = "\(lat ?? 0)"
        options["lng"] = "\(lng ?? 0)"
        presenter?.fetchFilter()
    }
    func didFailLocation() {
        
    }
}
extension SearchVC {
    @IBAction func filter(_ sender: Any) {
        router?.filter(with: filterOptions)
    }
    @IBAction func removeSearch(_ sender: Any) {
        text = nil
        setupSearchView()
        NotificationCenter.default.post(name: Notification.Name("NEW_SEARCH"), object: nil, userInfo: ["tags": filterOptions?.products ?? []])
    }
}
// MARK: - ...  View Contract
extension SearchVC: SearchViewContract {
    func didFetchFilter(for model: FilterOptionModel.DataClass?) {
        filterOptions = model
        NotificationCenter.default.post(name: Notification.Name("NEW_SEARCH"), object: nil, userInfo: ["tags": filterOptions?.products ?? []])

    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.count ?? 0 > 0 {
            SearchHistory().save(text: textField.text)
            text = textField.text
            setupSearchView()
        }
    }
}

extension SearchVC: SearchFilterDelegate {
    func searchFilter(_ filter: SearchFilterDelegate?, for options: [String : Any]) {
        var filter = options
        if text != nil {
            filter["name"] = text
        }
        NotificationCenter.default.post(name: Notification.Name("OPTIONS_SEARCH"), object: nil, userInfo: ["options": filter])
        miceBtn.setImage(#imageLiteral(resourceName: "Icon material-cancel"), for: .normal)
        UIView.animate(withDuration: 0.5) {
            self.newSearchContainer.isHidden = true
            self.searchResultContainer.isHidden = false
        }
    }
}
