//
//  WebViewVC.swift
//  DAL_Provider
//
//  Created by Mabdu on 05/05/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
import WebKit
// MARK: - ...  ViewController - Vars
class WebViewVC: BaseController {
    @IBOutlet weak var termsTextView: UITextView!
    var presenter: WebViewPresenter?
    var router: WebViewRouter?
    var settings: WebViewModel.DataClass?

}

// MARK: - ...  LifeCycle
extension WebViewVC {
    override func viewDidLoad() {
        super.viewDidLoad()
        super.hideNav = true
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
extension WebViewVC {
    func setup() {
        startLoading()
        presenter?.terms()
    }
    
}
// MARK: - ...  View Contract
extension WebViewVC: WebViewViewContract {
    func didFetch(for terms: String) {
        stopLoading()
        termsTextView.text = terms.htmlToString
    }
}
