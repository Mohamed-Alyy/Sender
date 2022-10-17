//
//  ProviderCartListVC.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 15/09/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

class ProviderCartListVC: BaseController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var searchTxf: UITextField!
    @IBOutlet weak var resturantsTbl: UITableView!
    var presenter: ProviderCartListPresenter?
    var router: ProviderCartListRouter?
    var providers: [ProviderCartListDatum]?

}

// MARK: - ...  LifeCycle
extension ProviderCartListVC {
    override func viewDidLoad() {
        super.hideNav = true
        super.viewDidLoad()
        presenter = .init()
        presenter?.view = self
        router = .init()
        router?.view = self
        setup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchProvidersCart()
    }
    
}

// MARK: - ...  Functions
extension ProviderCartListVC: ProviderCartListViewContract {
    func fetchProviders(for list: [ProviderCartListDatum]?) {
        self.providers = list ?? []
        resturantsTbl.reloadData()
    }
    
    
    
    func setup() {
        resturantsTbl.delegate = self
        resturantsTbl.dataSource = self
        
    }
     
}
extension ProviderCartListVC: UITableViewDelegate, UITableViewDataSource {
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return providers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: SearchCategoriesRestaurantCell.self, indexPath)
        cell.model = providers?.getElement(at:indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let providerId = providers?.getElement(at: indexPath.row)?.provider?.id else {return}
        router?.goToCart(providerId: providerId)
    }
}
  
