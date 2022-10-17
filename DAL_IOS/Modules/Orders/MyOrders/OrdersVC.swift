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
class OrdersVC: BaseController {
    enum Tab {
        case new
        case processing
        case completed
        init(title: String) {
            switch title {
            case "new":
                self = .new
            case "accepted":
                self = .processing
            case "refused":
                self = .completed
            case "completed":
                self = .completed
            case "finished":
                self = .completed
            case "cancelled":
                self = .completed
            default:
                self = .completed
            }
        }
    }
    @IBOutlet weak var newOrdersBtn: UIButton!
    @IBOutlet weak var processingBtn: UIButton!
    @IBOutlet weak var completedBtn: UIButton!
    @IBOutlet weak var ordersTbl: UITableView!
    var presenter: OrdersPresenter?
    var router: OrdersRouter?
    var currentTab: Tab = .new
    var orders: [OrdersModel.Datum] = []
}

// MARK: - ...  LifeCycle
extension OrdersVC {
    override func viewDidLoad() {
        super.hideNav = true
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserRoot.token() == nil {
            UserRoot.authroize() {
                self.tabBarController?.selectedIndex = 0
            }
            return
        }
        presenter = .init()
        presenter?.view = self
        router = .init()
        router?.view = self
        orders.removeAll()
        setup()
        newOrders(newOrdersBtn) 
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter = nil
        router = nil
    }
}
// MARK: - ...  Functions
extension OrdersVC {
    func setup() {
        ordersTbl.delegate = self
        ordersTbl.dataSource = self
    }
    func setupNewOrders(_ enable: Bool = false) {
        if enable {
            newOrdersBtn.setTitleColor(.white, for: .normal)
            newOrdersBtn.backgroundColor = R.color.mainColor() ?? .clear
        } else {
            newOrdersBtn.setTitleColor(.lightGray, for: .normal)
            newOrdersBtn.backgroundColor = .clear
        }
    }
    func setupProcessing(_ enable: Bool = false) {
        if enable {
            processingBtn.setTitleColor(.white, for: .normal)
            processingBtn.backgroundColor = R.color.mainColor() ?? .clear
        } else {
            processingBtn.setTitleColor(.lightGray, for: .normal)
            processingBtn.backgroundColor = .clear
        }
    }
    func setupCompletedOrders(_ enable: Bool = false) {
        if enable {
            completedBtn.setTitleColor(.white, for: .normal)
            completedBtn.backgroundColor = R.color.mainColor() ?? .clear
        } else {
            completedBtn.setTitleColor(.lightGray, for: .normal)
            completedBtn.backgroundColor = .clear
        }
    }
    func fetch() {
        startLoading()
        presenter?.fetchOrders(tab: currentTab)
    }
    func reload() {
        ordersTbl.reloadData()
    }
}
extension OrdersVC {
    @IBAction func newOrders(_ sender: Any) {
        orders.removeAll()
        setupNewOrders(true)
        setupProcessing()
        setupCompletedOrders()
        currentTab = .new
        fetch()
        reload()
    }
    @IBAction func processing(_ sender: UIButton) {
        orders.removeAll()
        setupNewOrders()
        setupProcessing(true)
        setupCompletedOrders()
        currentTab = .processing
        fetch()
        reload()
    }
    @IBAction func completedOrders(_ sender: Any) {
        orders.removeAll()
        setupNewOrders()
        setupProcessing()
        setupCompletedOrders(true)
        currentTab = .completed
        fetch()
        reload()
    }
}
// MARK: - ...  View Contract
extension OrdersVC: OrdersViewContract {
    func didFetch(for list: [OrdersModel.Datum]?) {
        stopLoading()
        orders.removeAll()
        orders.append(contentsOf: list ?? [])
        reload()
    }
    func didReOrderd() {
        self.tabBarController?.selectedIndex = 0
    }
}


extension OrdersVC: UITableViewDelegate, UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 30
//    }
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        if let headerView = view as? UITableViewHeaderFooterView {
//            headerView.contentView.backgroundColor = R.color.background()
//            headerView.backgroundView?.backgroundColor = R.color.background()
//            headerView.textLabel?.textColor = R.color.thirdTextColor()
//            headerView.textLabel?.fontLabel = "r16"
//        }
//    }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return orders.first?.createdAt
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: OrderCell.self, indexPath)
        cell.tab = currentTab
        cell.delegate = self
        cell.model = orders[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.order(for: orders.getElement(at: indexPath.row))
    }
}

extension OrdersVC: OrderCellDelegate {
    func orderCell(_ cell: OrderCell?, did reOrder: Bool?) {
        router?.reOrder(for: orders[cell?.path ?? 0])
    }
}

extension OrdersVC: OrderDetailsDelegate {
    func orderDetails(_ delegate: OrderDetailsDelegate?) {
        fetch()
    }
    func orderDetails(_ delegate: OrderDetailsDelegate?, forEdit: Bool) {
        router?.cart()
    }
}
