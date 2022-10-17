//
//  CreateCardVC.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 08/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

// MARK: - ...  ViewController - Vars
class CreateCardVC: BaseController {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var cardHolderNameTxf: UITextField!
    @IBOutlet weak var cardNumberTxf: UITextField!
    @IBOutlet weak var expirationDateTxf: UITextField!
    @IBOutlet weak var cvvTxf: UITextField!
    @IBOutlet weak var saveEditBT: UIButton!
    var presenter: CreateCardPresenter?
    var router: CreateCardRouter?
    weak var delegate: CreateCardDelegate?
    var oldCard: CardsListModel.Datum?
    var selectedTitle = ""
//    private let datePicker = UIDatePicker()
    let expiryDatePicker = MonthYearWheelPicker()
}

// MARK: - ...  LifeCycle
extension CreateCardVC {
    override func viewDidLoad() {
        super.hideNav = true
        super.viewDidLoad()
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter = .init()
        presenter?.view = self
        router = .init()
        router?.view = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        presenter = nil
//        router = nil
//        delegate = nil
    }
}

//MARK: - TextField as a Data Picker view

extension CreateCardVC : UITextFieldDelegate{
    
    private func addDatePicker(){
        expirationDateTxf.delegate = self
        expiryDatePicker.addTarget(self, action: #selector(monthYearWheelPickerDidChange), for: .valueChanged)
    }
    
    @objc private func monthYearWheelPickerDidChange() {
        expiryDatePicker.onDateSelected = {[weak self] (month, year) in
            let string = String(format: "%02d/%d", month, year)
            self?.expirationDateTxf.text = string
        }
    } 
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        expirationDateTxf.inputView = expiryDatePicker
    }
}

// MARK: - ...  Functions
extension CreateCardVC {
    func setup() {
//        startLoading()
        addDatePicker()
        if oldCard != nil {
            titleLbl.text = "Edit Card".localized
            saveEditBT.setTitle("EDIT".localized, for: .normal)
            setupOldAddress()
        }else{
            titleLbl.text = "Add a new payment card".localized
            saveEditBT.setTitle("CREATE".localized, for: .normal)
        }
    }
   
    func setupOldAddress() {
        cardHolderNameTxf.text = oldCard?.cardHolder
        cardNumberTxf.text = oldCard?.cardNumber
        cvvTxf.text = "\(oldCard?.cvv ?? 0)"
        expirationDateTxf.text = "\(oldCard?.expirationMonth ?? 0)/\(oldCard?.expirationYear ?? 0)"
    }
}
extension CreateCardVC {
    override func backBtn(_ sender: Any) {
        router?.back()
    }
    @IBAction func create(_ sender: Any) {
        if oldCard != nil {
            presenter?.edit()
        } else {
            presenter?.create()
        }
    }
     
     
}
// MARK: - ...  View Contract
extension CreateCardVC: CreateCardViewContract, PopupConfirmationViewContract {
    func didCreate() {
        router?.didCreate()
    }
    func didError(error: String?) {
        openConfirmation(title: error)
    }
    func didFetchCities(for model: CitiesModel?) {
         
    }
}
  
