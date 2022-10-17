//
//  AboutUsVC.swift
//  DAL_Provider
//
//  Created by Mabdu on 02/03/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class AboutUsVC: BaseController {
    @IBOutlet weak var aboutLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    var presenter: AboutUsPresenter?
    var router: AboutUsRouter?
//    var settings: AboutUsModel.DataClass?
    var contactInfo: ContactInfo?
}

// MARK: - ...  LifeCycle
extension AboutUsVC {
    override func viewDidLoad() {
        hideNav = true
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter = .init()
        presenter?.view = self
        router = .init()
        router?.view = self
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
extension AboutUsVC {
    func setup() {
        startLoading()
        presenter?.settings()
    }
    func reload() {
        addressLbl.text = contactInfo?.address
        phoneLbl.text = contactInfo?.phone
        emailLbl.text = contactInfo?.email
//        aboutLbl.attributedText = contactInfo?.about_us?.htmlToAttributedString
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
extension AboutUsVC: AboutUsViewContract {
    func didFetch(for setting: AboutModel?) {
        stopLoading()
        contactInfo = setting?.contactInfo
        aboutLbl.text = setting?.content?.htmlToString
        reload()
    }
    
//    func didFetch(for setting: AboutUsModel.DataClass?) {
//        stopLoading()
//        settings = setting
//        reload()
//    }
}
