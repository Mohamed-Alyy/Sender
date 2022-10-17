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
class ReservationDetailsVC: BaseController {
    @IBOutlet weak var centerTypeConstraint: NSLayoutConstraint!
    @IBOutlet weak var orderTypeLbl: UILabel!
    @IBOutlet weak var resturantImage: UIImageView!
    @IBOutlet weak var resturantLbl: UILabel!
    @IBOutlet weak var addressBtn: UIButton!
    @IBOutlet weak var personsLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var serviceLbl: UILabel!
    @IBOutlet weak var rejectView: UIView!
    @IBOutlet weak var rejectTitleLbl: UILabel!
    @IBOutlet weak var noteLbl: UILabel!
    @IBOutlet weak var statusBtn: GradientButton!
    @IBOutlet weak var newOrderView: UIView!
    @IBOutlet weak var rateProviderView: UIView!
    @IBOutlet weak var rateView: CosmosView!
    @IBOutlet weak var noteTxf: UITextField!
    var presenter: ReservationDetailsPresenter?
    var router: ReservationDetailsRouter?
    var tab: OrdersVC.Tab = .new
    var reservation: ReservationsModel.Datum?
    var reservationID: Int?
    weak var delegate: ReservationDetailsDelegate?
}

// MARK: - ...  LifeCycle
extension ReservationDetailsVC {
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
        setupUI()
        if reservationID != nil {
            startLoading()
            presenter?.fetchReservation(reservationID: reservationID)
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter = nil
        router = nil
    }
}
// MARK: - ...  Functions
extension ReservationDetailsVC {
    func setup() {
        if Localizer.current == .arabic {
            centerTypeConstraint.constant = 70
        } else {
            centerTypeConstraint.constant = -70
        }
        if tab == .new {
            setupUIForNewOrder()
        } else if tab == .processing {
            setupUIForNewOrder()
            setupUIForProcessOrder()
        } else {
            setupUIForCompleteOrder()
        }
    }
    func setupUI() {
        orderTypeLbl.text = "\("Order type".localized)  \("book table".localized)"
        orderTypeLbl.attributedText = orderTypeLbl.text?.colorOfWord("\("book table".localized)", with: R.color.secondColor() ?? .black)
        resturantImage.setImage(url: reservation?.providerImg)
        resturantLbl.text = reservation?.providerName
        personsLbl.text = "\(reservation?.qty ?? 0) \("persons".localized)"
        let dateDay = DateHelper().date(date: reservation?.reservationDate, format: "d MMM yyyy", oldFormat: "yyyy-MM-dd")
        let dateHour = DateHelper().date(date: reservation?.reservationTime, format: "h:mm a", oldFormat: "HH:mm:ss")
        dateLbl.text = "\(dateDay ?? "") , \(dateHour ?? "")"
        //serviceLbl.text = reservation?.featureName
        var services = ""
        var counter = 1
        for service in reservation?.features ?? [] {
            if counter == reservation?.features?.count {
                services += "\(service.name ?? "")"
            } else {
                services += "\(service.name ?? "") \n "
            }
            counter += 1
        }
        serviceLbl.text = services
        
        noteLbl.text = ""
        statusBtn.setTitle("\(reservation?.statusText ?? "")", for: .normal)
        rateView.rating = 0
        rateView.settings.emptyBorderWidth = 2
        if reservation?.status == 4 {
            noteLbl.text = reservation?.refuseal
            if reservation?.refuseal?.isEmpty == true {
                rejectView.isHidden = true
            } else {
                rejectView.isHidden = false
            }
        } else {
            rejectView.isHidden = true
        }
    }
    func setupUIForNewOrder() {
        rateProviderView.isHidden = true
    }
    func setupUIForProcessOrder() {
        newOrderView.isHidden = true
        rateProviderView.isHidden = true
    }
    func setupUIForCompleteOrder() {
        newOrderView.isHidden = true
        statusBtn.firstColor = R.color.textColorBlue() ?? .clear
        statusBtn.secondColor = R.color.textColorBlue() ?? .clear
        statusBtn.thirdColor = UIColor(red: 69/255, green: 212/255, blue: 207/255, alpha: 1)
        if reservation?.isRated == 1 || reservation?.status == 4 {
            rateProviderView.isHidden = true
        }
    }
    func createBookModel() -> ReservationTableModel {
        var book = ReservationTableModel()
        book.persons = reservation?.qty
        book.providerID = reservation?.providerID
        book.hour = reservation?.reservationTime
        book.date = reservation?.reservationDate
        book.services = reservation?.features
        book.reservationID = reservation?.id
        return book
    }
}
extension ReservationDetailsVC {
    override func backBtn(_ sender: Any) {
        router?.dismiss()
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
        presenter?.rateReservation(for: reservation, rate: rateView.rating, comment: noteTxf.text)
    }
    @IBAction func edit(_ sender: Any) {
        //startLoading()
        //presenter?.editOrder(for: order)
        router?.reserveTable(for: createBookModel())
    }
    @IBAction func cancel(_ sender: Any) {
        startLoading()
        presenter?.cancelReservation(for: reservation)
    }
}
// MARK: - ...  View Contract
extension ReservationDetailsVC: ReservationDetailsViewContract, PopupConfirmationViewContract {
    func didFetchReservation(reservation: ReservationsModel.Datum?) {
        stopLoading()
        self.reservation = reservation
        setup()
        setupUI()
    }
    func didRated() {
        rateView.isHidden = true
        stopLoading()
        router?.dismiss()
    }
    func didCancel() {
        stopLoading()
        router?.dismiss()
    }
    func didEdited() {
        
    }
}
