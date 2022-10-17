//
//  ShippingAddressVC.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 14/09/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//
 
 
import UIKit

// MARK: - ...  ViewController - Vars
class ShippingAddressVC: BaseController {
    
    @IBOutlet weak var addressesTbl: UITableView!
//    @IBOutlet weak var completeBtn: GradientButton!
    var presenter: ShippingAddressPresenter?
    var router: ShippingAddressRouter?
    var addresses: [AddressesModel.Datum] = []
    var selectedAddress: Int = 0
    var checkoutModel: CheckoutModel?
}

// MARK: - ...  LifeCycle
extension ShippingAddressVC {
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
extension ShippingAddressVC {
    func setup() {
        registerTableView()
        startLoading()
        presenter?.fetchAddresses()
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
extension ShippingAddressVC {
    override func backBtn(_ sender: Any) {
        router?.dismiss()
    }
}
// MARK: - ...  View Contract
extension ShippingAddressVC: ShippingAddressViewContract,ShippingAddressCellProtocol {
    func didSelectedAddress(_ row: Int) {
        addresses.forEach({$0.isSelected = false})
        addresses.getElement(at: row)?.isSelected = true
        addressesTbl.reloadData()
    }
    
    
    func addAnotherAddress() {
        router?.didCreate()
    }
    
    func didTappedChoiceOfDelivery(_ row: Int) {
        if let addressId = addresses.getElement(at: row)?.id {
            checkoutModel?.addressId = addressId
            checkoutModel?.addressName = addresses.getElement(at: row)?.type
            checkoutModel?.addressDes = addresses.getElement(at: row)?.datumDescription
            checkoutModel?.userLat = addresses.getElement(at: row)?.lat
            checkoutModel?.userLng = addresses.getElement(at: row)?.lng
            guard let checkoutModel = checkoutModel else {return}
            router?.didCompleteOrder(checkoutModel: checkoutModel)
        }
    }
    
    
    func didFetchAddresses(for list: [AddressesModel.Datum]?) {
        stopLoading()
        addresses.removeAll()
        addresses.append(contentsOf: list ?? [])
        addressesTbl.reloadData()
//        reload()
    }
    
    private func registerTableView(){
        addressesTbl.register(cell: ShippingAddressCell.self)
        addressesTbl.dataSource = self
        addressesTbl.delegate = self
        addressesTbl.tableFooterView = UIView()
    }
}

extension ShippingAddressVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return addresses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ShippingAddressCell = tableView.dequeue(indexPath: indexPath)
        cell.indexPath = indexPath
        cell.delegate = self
        cell.model = addresses[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        reloadHeight()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell: ShippingAddressFooterCell = ShippingAddressFooterCell.instanceFromNib()
        cell.delegate = self
        return cell
        
    }
     
}
