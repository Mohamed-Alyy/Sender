//
//  OrdersVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class FavoritesVC: BaseController {
 
    @IBOutlet weak var favoritesTbl: UITableView!
    var presenter: FavoritesPresenter?
    var router: FavoritesRouter?
    var providers: [ProvidersResult] = []
}

// MARK: - ...  LifeCycle
extension FavoritesVC {
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
extension FavoritesVC {
    func setup() {
        favoritesTbl.delegate = self
        favoritesTbl.dataSource = self
        favoritesTbl.reloadData()
    }
    
    func reload() {
        favoritesTbl.reloadData()
    }
    func fetch() {
        startLoading()
        presenter?.fetchFavorites()
    }
}
 
// MARK: - ...  View Contract
extension FavoritesVC: FavoritesViewContract {
    func didFetch(for list: [ProvidersResult]?) {
        self.providers = list ?? []
        reload()
    }
}


extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return providers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: ResturantTableCell.self, indexPath)
        cell.model = providers[indexPath.row]
        cell.delegate = self
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.provider(for: providers[indexPath.row])
    }
}

extension FavoritesVC: FavoriteCellDelegate {
    func favoriteCell(for cell: CellProtocol) {
        providers.remove(at: cell.path ?? 0)
        reload()
    }
}
