//
//  WithdrawWalletBalanceVC.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 13/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

class WithdrawWalletBalanceVC: BaseController {

    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var bankNameTextField: UITextField!
    @IBOutlet weak var accountHolderNameTextField: UITextField!
    @IBOutlet weak var bankAccountNumberTextField: UITextField!
    @IBOutlet weak var ibanTextField: UITextField!
    
    var banksModel: [BanksModel]?
    var selectedBankModel: BanksModel?
    override func viewDidLoad() {
        super.hideNav = true
        super.viewDidLoad()
        getBanks()
    }
    
    
    func showMessage(message: String?){
        guard let message = message, message != "" else {return}
        PopupConfirmationVC.confirmationPOPUP(view: self, title: message, btns: [.skip])
    }
    
    func WithdrawWalletBalance() {
        if UserRoot.token() == nil {
            UserRoot.authroize()
            return
        }
        startLoading()
        NetworkManager.instance.paramaters["bank_id"] = selectedBankModel?.id ?? 0
        NetworkManager.instance.paramaters["bank_account_number"] = bankAccountNumberTextField.text ?? ""
        NetworkManager.instance.paramaters["iban_number"] = ibanTextField.text ?? ""
        NetworkManager.instance.paramaters["holder_name"] = accountHolderNameTextField.text ?? ""
        NetworkManager.instance.request(.withdraw, type: .post, BaseModel<String>.self) { [weak self] (response) in
            guard let self = self else {return}
            defer { self.stopLoading() }
            switch response {
            case .success(let model):
                self.showMessage(message: model?.message ?? "")
                case .failure(let error):
                self.showMessage(message: error?.localizedDescription)
            }
        }
    }
    
    func getBanks() {
        if UserRoot.token() == nil {
            UserRoot.authroize()
            return
        }
        startLoading()
        NetworkManager.instance.request(.banks, type: .get, BaseModel<[BanksModel]>.self) { [weak self] (response) in
            guard let self = self else {return}
            defer { self.stopLoading() }
            switch response {
                case .success(let model):
                self.banksModel = model?.data ?? []
                case .failure:
                    break
            }
        }
    }
    
    @IBAction
    func didTappedConfirmButton(_ sender: Any) {
        WithdrawWalletBalance()
    }
    
    @IBAction
    func didTappedBanksButton(_ sender: Any) {
        guard let scene = R.storyboard.pickerViewHelper.pickerController() else { return }
        scene.source = banksModel ?? []
        scene.titleClosure = { [weak self] row in
            return self?.banksModel?.getElement(at: row)?.title
        }
        scene.didSelectClosure = { [weak self] row in
            let item = self?.banksModel?.getElement(at: row)
            self?.bankNameTextField.text = item?.title
            self?.selectedBankModel = item
        }
        pushPop(scene)
    }
    
}
