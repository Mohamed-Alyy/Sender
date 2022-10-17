//
//  ContactUsVC.swift
//  DAL_Provider
//
//  Created by Mabdu on 02/03/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ContactUsVC: BaseController {
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var nameTxf: UITextField!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var emailTxf: UITextField!
//    @IBOutlet weak var addressView: UIView!
//    @IBOutlet weak var addressTxf: UITextField!
    @IBOutlet weak var whatsappView: UIView!
    @IBOutlet weak var whatsappTxf: UITextField!
    @IBOutlet weak var messageView: UIView!
    @IBOutlet weak var messageTxv: UITextView!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    var presenter: ContactUsPresenter?
    var aboutPresenter: AboutUsPresenter?
    var router: ContactUsRouter?
//    var settings: AboutUsModel.DataClass?
    var contact: ContactUsModel?
    var contactInfo: ContactInfo?
}

// MARK: - ...  LifeCycle
extension ContactUsVC {
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
        aboutPresenter = .init()
        aboutPresenter?.view = self
        setup()
        reload()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter = nil
        router = nil
    }
}
// MARK: - ...  Functions
extension ContactUsVC {
    func setup() {
        startLoading()
        aboutPresenter?.settings()
    }
    func reload() {
        addressLbl.text = contactInfo?.address
        phoneLbl.text = contactInfo?.phone
        emailLbl.text = contactInfo?.email
    }
    @IBAction func send(_ sender: Any) {
        view.endEditing(true)
        if !validate(txfs: [nameTxf, emailTxf, whatsappTxf]) {
            return
        }
        if messageTxv.text == messageTxv.localization {
            messageTxv.textColor = .red
            return
        }
        contact = .init()
        contact?.name = nameTxf.text
        contact?.email = emailTxf.text
//        contact?.address = addressTxf.text
        contact?.message = messageTxv.text
        contact?.whatsapp = whatsappTxf.text
        startLoading()
        presenter?.contact(contact: contact)
    }
    @IBAction func address(_ sender: Any) {
    }
    @IBAction func email(_ sender: Any) {
        Common().sendMail(text: contactInfo?.email)
    }
    @IBAction func mobile(_ sender: Any) {
        Common().call(text: contactInfo?.phone)
    }
}
// MARK: - ...  View Contract
extension ContactUsVC: ContactUsViewContract, AboutUsViewContract, PopupConfirmationViewContract {
    func didFetch(for setting: AboutModel?) {
        
    }
    
    func didFetch(for setting: ContactInfo?) {
        stopLoading()
        self.contactInfo = setting
        reload()
    }
    
    func didSend(message: String?) {
        openConfirmation(title: message, btns: [.agree], onSkipClosure: nil) {
            self.router?.restart()
        }
    }
    func didError(error: String?) {
        openConfirmation(title: error)
    }
}

extension ContactUsVC: UITextFieldDelegate {
    
}
