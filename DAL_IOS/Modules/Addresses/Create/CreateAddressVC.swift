//
//  CreateAddressVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/7/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class CreateAddressVC: BaseController {
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var addressNameTxf: UITextField!
    @IBOutlet weak var addressNameView: UIView!
    @IBOutlet weak var addressTitleTxf: UITextField!
    @IBOutlet weak var locationLb: UILabel!
    @IBOutlet weak var detailsTxf: UITextField!
    @IBOutlet weak var saveEditBT: UIButton!
    var presenter: CreateAddressPresenter?
    var router: CreateAddressRouter?
    weak var delegate: CreateAddressDelegate?
    var cities: [CitiesModel.Datum] = []
    var districts: [CitiesModel.Area] = []
    var city: CitiesModel.Datum?
    var district: CitiesModel.Area?
    var oldAddress: AddressesModel.Datum?
    var googleHelper: GoogleMapHelper?
    var paramters: [String: Any] = [:]
    private var pickerView = UIPickerView()
    private var currentTextField = UITextField()
    var addressesTitle = ["home","work","other"]
    var selectedTitleIndex = 0
}

// MARK: - ...  LifeCycle
extension CreateAddressVC {
    override func viewDidLoad() {
        super.hideNav = true
        super.viewDidLoad()
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        googleHelper = .init()
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
// MARK: - ...  Functions
extension CreateAddressVC {
    func setup() {
//        startLoading()
        addressNameView.isHidden = true
        addressTitleTxf.delegate = self
        if oldAddress != nil {
            titleLbl.text = "Edit address".localized
            saveEditBT.setTitle("EDIT".localized, for: .normal)
            setupOldAddress()
        }else{
            titleLbl.text = "New address".localized
            saveEditBT.setTitle("CREATE".localized, for: .normal)
            setLocationText(isPlacHolder: true)
        }
    }
    
    private func setLocationText(isPlacHolder: Bool,address: String = ""){
        switch isPlacHolder {
        case true :
            locationLb.text = "Location".localized
            locationLb.textColor = UIColor.lightGray
        case false:
            locationLb.text = address
            locationLb.textColor = UIColor.black
        }
    }
    
    func setupOldAddress() {
        self.googleHelper?.address(lat: Double(oldAddress?.lat ?? "0") ?? 0, lng: Double(oldAddress?.lng ?? "0") ?? 0, handler: { [weak self] (title, snippet, city) in
            self?.setLocationText(isPlacHolder: title == "", address: title)
        })
        addressTitleTxf.text = oldAddress?.type
        addressNameTxf.text = oldAddress?.name
        detailsTxf.text = oldAddress?.datumDescription
        paramters["lat"] = oldAddress?.lat
        paramters["lng"] = oldAddress?.lng
        if let index = addressesTitle.firstIndex(where: {$0 == oldAddress?.typeKey}) {
            selectedTitleIndex = index
        }
    }
    
}
extension CreateAddressVC {
    override func backBtn(_ sender: Any) {
        router?.back()
    }
    @IBAction func create(_ sender: Any) {
        if oldAddress != nil {
            presenter?.edit()
        } else {
            presenter?.create()
        }
    }
    
    @IBAction
    func didTappedOnLocationButton(_ sender: Any) {
        router?.openMap()
    }
     
}
// MARK: - ...  View Contract
extension CreateAddressVC: CreateAddressViewContract, PopupConfirmationViewContract {
    func didCreate() {
        router?.didCreate()
    }
    func didError(error: String?) {
        openConfirmation(title: error)
    }
    func didFetchCities(for model: CitiesModel?) {
         
    }
}

extension CreateAddressVC: LocationFromMapDelegateContract {
    func saveLocation(lat: Double?, lng: Double?, address: String?) {
        paramters["lat"] = "\(lat ?? 0)"
        paramters["lng"] = "\(lng ?? 0)"
        setLocationText(isPlacHolder: address == "", address: address ?? "")
//        addressEditTxf.text = address
    }
    func didFailLocation() {
        
    }
}

//MARK: - TextField as a Data Picker view

extension CreateAddressVC : UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currentTextField = textField
        if currentTextField == addressTitleTxf {
            currentTextField.inputView = pickerView
            pickerView.delegate = self
            pickerView.dataSource = self
            pickerView.reloadAllComponents()
        }
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if currentTextField == addressTitleTxf {
            return addressesTitle.count
        }else{
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if currentTextField == addressTitleTxf {
            return addressesTitle.getElement(at: row)?.localized
        }else{
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if currentTextField == addressTitleTxf {
            addressTitleTxf.text =  addressesTitle.getElement(at: row)?.localized
            addressNameView.isHidden = row != 2
            selectedTitleIndex = row
        }
         
        currentTextField.resignFirstResponder()
      }
 }
