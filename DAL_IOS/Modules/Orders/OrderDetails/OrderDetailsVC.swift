//
//  OrderDetailsVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
import Cosmos
// MARK: - ...  ViewController - Vars
class OrderDetailsVC: BaseController {
    @IBOutlet weak var resturantImage: UIImageView!
    @IBOutlet weak var resturantLbl: UILabel!
    @IBOutlet weak var addressBtn: UIButton!
    @IBOutlet weak var discountLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var statusBtn: UIButton!
    @IBOutlet weak var taxLbl: UILabel!
    @IBOutlet weak var mealsTbl: UITableView!
    @IBOutlet weak var addtionsTbl: UITableView!
    @IBOutlet weak var mealsPriceLbl: UILabel!
    @IBOutlet weak var extrasPriceLbl: UILabel!
    @IBOutlet weak var totalPriceLbl: UILabel!
    @IBOutlet weak var newOrderView: UIView!
    @IBOutlet weak var rateProviderView: UIView!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var noteTxf: UITextField!
    @IBOutlet weak var deliveryFeesView: UIView!
    @IBOutlet weak var deliveryFeesLbl: UILabel!
    @IBOutlet weak var extrasView: UIView!
    @IBOutlet weak var paymentMethodLbl: UILabel!
    @IBOutlet weak var noteLbl: UILabel!
    var presenter: OrderDetailsPresenter?
    var router: OrderDetailsRouter?
    var tab: OrdersVC.Tab = .new
    var order: OrdersModel.Datum?
    var orderID: Int?
    var forceRate: Bool = false
    weak var delegate: OrderDetailsDelegate?
    var googleHelper: GoogleMapHelper?
    var additions: [AdditionsModel] {
        var additions = [AdditionsModel]()
        for addition in order?.items ?? [] {
            additions.append(contentsOf: addition.additions ?? [])
        }
        return additions
    }
}

// MARK: - ...  LifeCycle
extension OrderDetailsVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        rateView.semanticContentAttribute = .forceLeftToRight
        theme()
        setTableView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter = .init()
        presenter?.view = self
        router = .init()
        router?.view = self
        googleHelper = .init()
        if orderID != nil {
            startLoading()
            presenter?.fetchOrder(orderID: orderID)
        }else{
            setup()
            setupUI()
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter = nil
        router = nil
    }
}
// MARK: - ...  Functions
extension OrderDetailsVC {
    private func theme(){
        statusBtn.backgroundColor = R.color.mainColor() ?? .clear
        statusBtn.layer.cornerRadius = statusBtn.frame.height / 2
    }
    
    func setup() {
        if tab == .new {
            setupUIForNewOrder()
        } else if tab == .processing {
            setupUIForNewOrder()
            setupUIForCompleteOrder()
        } else {
            setupUIForCompleteOrder()
        }
    }
    func setupUI() {
        resturantImage.setImage(url: order?.provider?.avatar)
        resturantLbl.text = order?.provider?.name
        self.googleHelper?.address(lat: Double(order?.address?.lat ?? "") ?? 0, lng: Double(order?.address?.lng ?? "") ?? 0, handler: { [weak self] (title, snippet, city) in
            self?.addressBtn.setTitle(title, for: .normal)
        })
        
        addressBtn.UIViewAction {
            //let navigate = NavigateMap(lat: order., lng: <#T##Double?#>, title: <#T##String?#>)
        }
        dateLbl.text = "\(order?.times?.createdAt ?? "")"
        statusBtn.setTitle("\(order?.status ?? "")", for: .normal)
        paymentMethodLbl.text = order?.payment?.paymentMethod?.capitalized.localized
        noteLbl.text = order?.notes ?? ""
        setupPrices()
        rateView.settings.emptyBorderWidth = 2
        
    }
    
    private func setTableView(){
        mealsTbl.rowHeight = UITableView.automaticDimension
        mealsTbl.estimatedRowHeight = 250
        mealsTbl.delegate = self
        mealsTbl.dataSource = self
        mealsTbl.reloadData()
        mealsTbl.scrollToBottom()
        addtionsTbl.delegate = self
        addtionsTbl.dataSource = self
        addtionsTbl.reloadData()
        addtionsTbl.scrollToBottom()
        reloadHeight()
    }
    func setupPrices() {
        var mealPrice = 0.0
        var extraPrice = 0.0
        for meal in order?.items ?? [] {
            //mealPrice += meal.total?.double ?? 0
            mealPrice += (Double(meal.peicePrice ?? "0") ?? 0) * Double((meal.quantity ?? 0))
            for extra in additions{
                extraPrice += (extra.quantity ?? 0).double * (Double(extra.peicePrice ?? "0") ?? 0)
            }
        }
         
        taxLbl.text = "\("Includes value added".localized) \(order?.tax ?? "0") \("SAR".localized)"

        //taxLbl.text = "\("Includes value added".localized) \(order?.tax ?? 0)%"
        deliveryFeesLbl.text = "\(order?.deliveryPrice ?? "0") \("SAR".localized)"
        mealsPriceLbl.text = "\(mealPrice.string) \("SAR".localized)"
        extrasPriceLbl.text = "\(extraPrice.string) \("SAR".localized)"
        totalPriceLbl.text = order?.total ?? "0"
        discountLbl.text = "\(order?.discount_amount ?? "0") \("SAR".localized)"
        if extraPrice == 0.0 {
            extrasView.isHidden = true
        }
        
    }
    func setupUIForNewOrder() {
        rateProviderView.isHidden = true
    }
    func setupUIForCompleteOrder() {
        newOrderView.isHidden = true
        
        if order?.statusKey == "new" || order?.statusKey == "pending" || order?.statusKey == "canceled" || order?.statusKey == "refused" {
            rateProviderView.isHidden = true
        }
        
        
    }
    
    
}
extension OrderDetailsVC {
    override func backBtn(_ sender: Any) {
        router?.dismiss()
    }
    @IBAction func edit(_ sender: Any) {
        startLoading()
        presenter?.editOrder(for: order)
    }
    @IBAction func cancel(_ sender: Any) {
        startLoading()
        presenter?.cancelOrder(for: order)
    }
    @IBAction func rate(_ sender: Any) {
//        if !validate(txfs: [noteTxf]) {
//            return
//        }
        if rateView.rating == 0 {
            openConfirmation(title: "Please rate the resturant first!".localized)
            return
        }
        startLoading()
        presenter?.rateOrder(for: order, rate: rateView.rating, comment: noteTxf.text)
    }
}
// MARK: - ...  View Contract
extension OrderDetailsVC: OrderDetailsViewContract, PopupConfirmationViewContract {
    func didFetchOrder(order: OrdersModel.Datum?) {
        stopLoading()
        self.order = order
        setup()
        setupUI()
        reloadHeight()
        mealsTbl.reloadData()
        addtionsTbl.reloadData()
    }
    func didCancel() {
        stopLoading()
        router?.dismiss()
    }
    
    func didEdited() {
        stopLoading()
        router?.didEdited()
    }
    
    func didRated() {
        forceRate = false
        rateView.isHidden = true
        stopLoading()
        router?.dismiss()
    }
    func didError(error: String?) {
        stopLoading()
        openConfirmation(title: error)
        return
    }
}

extension OrderDetailsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case mealsTbl :
        return order?.items?.count ?? 0
        default:
            return additions.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tableView {
        case mealsTbl :
            var cell = tableView.cell(type: OrderProductCell.self, indexPath)
            cell.tab = tab
            cell.model = order?.items?[indexPath.row]
            cell.theme()
            return cell
        default:
            var cell = tableView.cell(type: ExtraMealCell.self, indexPath)
            cell.model = additions.getElement(at: indexPath.row)
            cell.removeBtn.isHidden = true
            cell.removeView.isHidden = true
            cell.bottomStackView.isHidden = true
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        reloadHeight()
    }
    func reloadHeight() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
//            if let constraint = self.mealsTbl.constraints.first(where: { $0.firstAttribute == .height }) {
//                constraint.constant = self.mealsTbl.contentSize.height
//            }
//
//            if let constraint = self.addtionsTbl.constraints.first(where: { $0.firstAttribute == .height }) {
//                constraint.constant =  55 * (self.additions.count.cgFloat)
//            }
//        }
        
    }
}
