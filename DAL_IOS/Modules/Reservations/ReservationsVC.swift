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
class ReservationsVC: BaseController {
    @IBOutlet weak var newOrdersBtn: GradientButton!
    @IBOutlet weak var processingBtn: GradientButton!
    @IBOutlet weak var completedBtn: GradientButton!
    @IBOutlet weak var reservationsTbl: UITableView!
    var presenter: ReservationsPresenter?
    var router: ReservationsRouter?
    var currentTab: OrdersVC.Tab = .new
    var reservations: [ReservationsModel.Datum] = []
}

// MARK: - ...  LifeCycle
extension ReservationsVC {
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
        newOrders(newOrdersBtn)
        fetch()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter = nil
        router = nil
    }
}
// MARK: - ...  Functions
extension ReservationsVC {
    func setup() {
        reservationsTbl.delegate = self
        reservationsTbl.dataSource = self
    }
    func setupNewOrders(_ enable: Bool = false) {
        if enable {
            newOrdersBtn.setTitleColor(.white, for: .normal)
            newOrdersBtn.firstColor = R.color.mainColor() ?? .clear
            newOrdersBtn.secondColor = R.color.secondColor() ?? .clear
        } else {
            newOrdersBtn.setTitleColor(R.color.thirdTextColor(), for: .normal)
            newOrdersBtn.firstColor = .clear
            newOrdersBtn.secondColor = .clear
        }
    }
    func setupProcessing(_ enable: Bool = false) {
        if enable {
            processingBtn.setTitleColor(.white, for: .normal)
            processingBtn.firstColor = R.color.mainColor() ?? .clear
            processingBtn.secondColor = R.color.secondColor() ?? .clear
        } else {
            processingBtn.setTitleColor(R.color.thirdTextColor(), for: .normal)
            processingBtn.firstColor = .clear
            processingBtn.secondColor = .clear
        }
    }
    func setupCompletedOrders(_ enable: Bool = false) {
        if enable {
            completedBtn.setTitleColor(.white, for: .normal)
            completedBtn.firstColor = R.color.mainColor() ?? .clear
            completedBtn.secondColor = R.color.secondColor() ?? .clear
        } else {
            completedBtn.setTitleColor(R.color.thirdTextColor(), for: .normal)
            completedBtn.firstColor = .clear
            completedBtn.secondColor = .clear
        }
    }
    func fetch() {
        startLoading()
        presenter?.fetchReservations(tab: currentTab)
    }
    func reload() {
        reservationsTbl.reloadData()
    }
}
extension ReservationsVC {
    @IBAction func newOrders(_ sender: UIButton) {
        setupNewOrders(true)
        setupProcessing()
        setupCompletedOrders()
        currentTab = .new
        fetch()
        reload()
    }
    @IBAction func processing(_ sender: UIButton) {
        setupNewOrders()
        setupProcessing(true)
        setupCompletedOrders()
        currentTab = .processing
        fetch()
        reload()
    }
    @IBAction func completedOrders(_ sender: UIButton) {
        setupNewOrders()
        setupProcessing()
        setupCompletedOrders(true)
        currentTab = .completed
        fetch()
        reload()
    }
    @IBAction func filter(_ sender: UIButton) {
        router?.filter()
    }
}
// MARK: - ...  View Contract
extension ReservationsVC: ReservationsViewContract {
    func didFetch(for list: [ReservationsModel.Datum]?) {
        stopLoading()
        reservations.removeAll()
        reservations.append(contentsOf: list ?? [])
        reload()
    }
    func didFinishReservation(for id: Int?) {
        stopLoading()
        completedOrders(completedBtn)
    }
    func didAccept() {
        stopLoading()
        processing(processingBtn)
    }
}


extension ReservationsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = R.color.background()
            headerView.backgroundView?.backgroundColor = R.color.background()
            headerView.textLabel?.textColor = R.color.thirdTextColor()
            headerView.textLabel?.fontLabel = "r16"
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return reservations.first?.date
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: ReservationCell.self, indexPath)
        cell.tab = currentTab
        cell.model = reservations[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.reservation(for: reservations[indexPath.row])
    }
}

extension ReservationsVC: ReservationDetailsDelegate {
    func reservationDetails(_ delegate: ReservationDetailsDelegate?) {
        fetch()
        reload()
    }
}

extension ReservationsVC: ReservationFilterDelegate {
    func reservationFilter(_ delegate: ReservationFilterDelegate?, for filter: ReservationsFilterModel?) {
        startLoading()
        presenter?.filterReservations(filter: filter)
    }
}
