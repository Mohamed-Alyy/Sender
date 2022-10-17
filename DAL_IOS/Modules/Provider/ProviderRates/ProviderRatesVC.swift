//
//  ProviderRatesVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/24/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ProviderRatesVC: BaseController {
    @IBOutlet weak var allRatesLbl: UILabel!
    @IBOutlet weak var ratesTbl: UITableView!
    var presenter: ProviderRatesPresenter?
    var router: ProviderRatesRouter?
    var provider: ProvidersResult?
    var rates: [ProviderRatingsDatum] = []
}

// MARK: - ...  LifeCycle
extension ProviderRatesVC {
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
extension ProviderRatesVC {
    func setup() {
        ratesTbl.delegate = self
        ratesTbl.dataSource = self
//        rates.append(contentsOf: provider?.rates ?? [])
        ratesTbl.reloadData()
        allRatesLbl.text = "(\(rates.count))"
//        presenter?.fetchRates(for: provider?.id)
    }
}
// MARK: - ...  View Contract
extension ProviderRatesVC: ProviderRatesViewContract {
    func didFetchRates(for list: [Provider.Rate]?) {
        allRatesLbl.text = "(\(list?.count ?? 0))"
//        rates.removeAll()
//        rates.append(contentsOf: list ?? [])
    }
}
extension ProviderRatesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: RateTableCell.self, indexPath)
        cell.model = rates.getElement(at: indexPath.row)
        return cell
    }
}
