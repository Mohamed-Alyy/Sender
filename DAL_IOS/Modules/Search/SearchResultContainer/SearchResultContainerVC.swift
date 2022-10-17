//
//  SearchResultContainerVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/18/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class SearchResultContainerVC: BaseController {
    @IBOutlet weak var resultsBtn: UIButton!
    @IBOutlet weak var resultsTbl: UITableView!
    var presenter: SearchResultContainerPresenter?
    var router: SearchResultContainerRouter?
    var providers: [Provider] = []
    var options: [String: Any] = [:]
}

// MARK: - ...  LifeCycle
extension SearchResultContainerVC {
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
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter = nil
        router = nil
    }
}
// MARK: - ...  Functions
extension SearchResultContainerVC {
    func setup() {
        resultsTbl.delegate = self
        resultsTbl.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("OPTIONS_SEARCH"), object: nil)
    }
    func search() {
        startLoading()
        presenter?.options = options
        presenter?.search()
    }
    @objc func methodOfReceivedNotification(notification: Notification) {
        let options = notification.userInfo?["options"] as? [String: Any]
        self.options = options ?? [:]
        self.presenter?.resetPaginator()
        self.providers.removeAll()
        search()
    }
    func reloadHeight() {
        if let constraint = resultsTbl.constraints.first(where: { $0.firstAttribute == .height }) {
            constraint.constant = 95 * providers.count.cgFloat
        }
    }
}
// MARK: - ...  View Contract
extension SearchResultContainerVC: SearchResultContainerViewContract {
    func didSearch(for list: [Provider]?) {
        stopLoading()
        providers.removeAll()
        providers.append(contentsOf: list ?? [])
        resultsTbl.stopSwipeButtom()
        resultsTbl.reloadData()
        resultsBtn.setTitle("\("Result".localized) \(providers.count)", for: .normal)
    }
}

extension SearchResultContainerVC: UITableViewDelegate, UITableViewDataSource {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if presenter?.canPaginate() == true {
            resultsTbl.swipeButtomRefresh { [weak self] in
                self?.search()
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return providers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: ResturantSearchCell.self, indexPath)
        cell.model = providers[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        reloadHeight()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: Notification.Name("SELECT_PROVIDER"), object: nil, userInfo: ["provider": providers[indexPath.row]])
    }
}
