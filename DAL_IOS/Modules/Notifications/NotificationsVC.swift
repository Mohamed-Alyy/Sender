//
//  NotificationsVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/20/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class NotificationsVC: BaseController {
    @IBOutlet weak var notificationsTbl: UITableView!
    var presenter: NotificationsPresenter?
    var router: NotificationsRouter?
    var notifications: [NotificationsModel.Datum] = []
}

// MARK: - ...  LifeCycle
extension NotificationsVC {
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
extension NotificationsVC {
    func setup() {
        startLoading()
        presenter?.fetchNotifications()
        notificationsTbl.delegate = self
        notificationsTbl.dataSource = self
    }
}
// MARK: - ...  View Contract
extension NotificationsVC: NotificationsViewContract {
    func didFetch(for list: [NotificationsModel.Datum]) {
        stopLoading()
        notifications.removeAll()
        notifications.append(contentsOf: list)
        notificationsTbl.reloadData()
    }
}

extension NotificationsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: NotificationCell.self, indexPath)
        cell.model = notifications[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if notifications.getElement(at: indexPath.row)?.notifyType == "order" {
            router?.navigateToOrder(orderID: notifications[indexPath.row].orderID, tab: .init(title: notifications[indexPath.row].type ?? ""))
        } else if notifications.getElement(at: indexPath.row)?.notifyType == "reservation" {
            router?.navigateToReservation(reservationID: notifications.getElement(at: indexPath.row)?.reservationID, tab: .init(title: notifications.getElement(at: indexPath.row)?.type ?? ""))
        }
    }
    
}
