//
//  AddressesVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/7/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class AddressesVC: BaseController {
    @IBOutlet weak var addressesTbl: UITableView!
//    @IBOutlet weak var completeBtn: GradientButton!
    var presenter: AddressesPresenter?
    var router: AddressesRouter?
    weak var delegate: AddressesDelegate?
    var addresses: [AddressesModel.Datum] = []
    var selectedAddress: Int = 0
    var fromProfile: Bool = false
    var googleHelper: GoogleMapHelper?
    
}

// MARK: - ...  LifeCycle
extension AddressesVC {
    override func viewDidLoad() {
        super.hideNav = true
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        googleHelper = .init()
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
extension AddressesVC {
    func setup() {
        registerTableView()
        startLoading()
        presenter?.fetchAddresses()
//        if fromProfile {
//            completeBtn.isHidden = true
//        }
    }
    func reload() {
        addressesTbl.estimatedRowHeight = 120
        addressesTbl.reloadData()
        addressesTbl.scrollToBottom()
        reloadHeight()
    }
    func reloadHeight() {
        if let constraint = addressesTbl.constraints.first(where: { $0.firstAttribute == .height }) {
            constraint.constant = addressesTbl.contentSize.height + 10
        }
    }
}
extension AddressesVC {
    override func backBtn(_ sender: Any) {
        router?.dismiss()
    }
    @IBAction func createAddress(_ sender: Any) {
        router?.didCreate()
    }
    @IBAction func completeOrder(_ sender: Any) {
        if let address = addresses[safe: selectedAddress]?.id {
            router?.didCompleteOrder(for: address)
        }
    }
}
// MARK: - ...  View Contract
extension AddressesVC: AddressesViewContract {
    func didFetchAddresses(for list: [AddressesModel.Datum]?) {
        stopLoading()
        addresses.removeAll()
        addresses.append(contentsOf: list ?? [])
        reload()
    }
    
    private func registerTableView(){
        addressesTbl.register(cell: AddressTableCell.self)
        addressesTbl.dataSource = self
        addressesTbl.delegate = self
        addressesTbl.tableFooterView = UIView()
    }
}

extension AddressesVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: AddressTableCell = tableView.dequeue(indexPath: indexPath)
//        if selectedAddress == indexPath.row {
//            cell.isChecked = true
//        } else {
//            cell.isChecked = false
//        }
        cell.indexPath = indexPath
        cell.delegate = self
        cell.model = addresses[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        reloadHeight()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.router?.didEdit(for: self.addresses.getElement(at: indexPath.row))
    }
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
//        if Localizer.current == .english {
//            guard orientation == .right else { return nil }
//        } else {
//            guard orientation == .left else { return nil }
//        }
//        let action = SwipeAction(style: .default, title: "".localized) { (action, path) in
////            self.presenter?.deleteAddress(for: self.addresses[path.row].id ?? 0)
////            self.addresses.remove(at: indexPath.row)
////            self.reload()
//            self.router?.didEdit(for: self.addresses[indexPath.row])
//
//        }
//        action.image = UIImage(named: "Iconly-Light-Setting")
//        action.backgroundColor = .white
//        let action1 = SwipeAction(style: .default, title: "".localized) { (action, path) in
//            self.presenter?.deleteAddress(for: self.addresses[path.row].id ?? 0)
//            self.addresses.remove(at: indexPath.row)
//            self.reload()
//        }
//        action1.image = UIImage(named: "Icon material-cancel-1")
//        action1.backgroundColor = .white
//        return [action, action1]
//    }
}


extension AddressesVC: AddressTableCellProtocol {
    func didTappedDelete(_ row: Int) {
        self.presenter?.deleteAddress(for: self.addresses[row].id ?? 0)
        self.addresses.remove(at: row)
        self.reload()
    }
    
    func didTappedMakeAsDefult(_ row: Int) {
        self.presenter?.setAddressAsDefult(for: self.addresses[row].id ?? 0)
    }
}
