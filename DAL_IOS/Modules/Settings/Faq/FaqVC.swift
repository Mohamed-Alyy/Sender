//
//  FaqVC.swift
//  DAL_Provider
//
//  Created by Mabdu on 02/03/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class FaqVC: BaseController {
    
    @IBOutlet weak var termsTextView: UITextView!
    
    var presenter: FaqPresenter?
    var router: FaqRouter?
    var questions: [FaqModel.Datum] = []
    var expandablePath: Int?
}

// MARK: - ...  LifeCycle
extension FaqVC {
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
extension FaqVC {
    func setup() {
        startLoading()
        presenter?.terms()
    }
}
// MARK: - ...  View Contract
extension FaqVC: FaqViewContract {
    func didFetch(for terms: String) {
        stopLoading()
        termsTextView.text = terms.htmlToString
    }
    
}
 
