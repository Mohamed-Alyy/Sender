//
//  MealExtrasVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/25/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class MealExtrasVC: BaseController {
    @IBOutlet weak var extrasTbl: UITableView!
    @IBOutlet weak var totalPriceLbl: UILabel!
    var presenter: MealExtrasPresenter?
    var router: MealExtrasRouter?
    weak var delegate: MealExtrasDelegate?
    var meal: ProviderCategoriesMealsDatum?
    var totalPrice: Double = 0
}

// MARK: - ...  LifeCycle
extension MealExtrasVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter = .init()
        presenter?.view = self
        router = .init()
        router?.view = self
        setup()
        updatePrices()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter = nil
        router = nil
    }
}
// MARK: - ...  Functions
extension MealExtrasVC {
    func setup() {
        extrasTbl.delegate = self
        extrasTbl.dataSource = self
    }
    func updatePrices() {
        totalPrice = 0
        var counter = 0
        for extra in meal?.additions ?? [] {
            if extra.quantity == nil {
                meal?.additions?[counter].quantity = 0
            }
            if extra.isChecked == true && extra.quantity ?? 0 > 0 {
                let extraPrice = (extra.quantity ?? 0).double * (Double(extra.price ?? "0") ?? 0)
                totalPrice += extraPrice
            }
            counter += 1
        }
        totalPriceLbl.text = totalPrice.string
    }
}
extension MealExtrasVC {
    override func backBtn(_ sender: Any) {
        router?.didPlusExtras()
    }
    @IBAction func add(_ sender: Any) {
        router?.didPlusExtras(didEdit: true)
    }
}
// MARK: - ...  View Contract
extension MealExtrasVC: MealExtrasViewContract {
}

extension MealExtrasVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        meal?.additions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: MealExtraEditCell.self, indexPath)
        cell.model = meal?.additions?[indexPath.row]
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if meal?.additions?[indexPath.row].isChecked == true && meal?.additions?[indexPath.row].quantity == 0 {
            meal?.additions?[indexPath.row].isChecked = false
        } else {
            meal?.additions?[indexPath.row].isChecked = true
            if meal?.additions?[indexPath.row].quantity ?? 0 < 1 {
                meal?.additions?[indexPath.row].quantity = 1
            }
        }
        updatePrices()
        tableView.reloadData()
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
}

extension MealExtrasVC: MealExtraEditDelegate {
    func mealExtraEdit(for cell: MealExtraEditCell, quantity: Int?) {
        if quantity == 0 {
            meal?.additions?[cell.indexPath()].isChecked = false
            extrasTbl.reloadData()
        } else {
            meal?.additions?[cell.indexPath()].isChecked = true
        }
        meal?.additions?[cell.indexPath()].quantity = quantity
        updatePrices()
    }
}
