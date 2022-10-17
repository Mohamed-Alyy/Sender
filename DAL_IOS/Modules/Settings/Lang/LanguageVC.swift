//
//  LanguageVC.swift
//  DAL_IOS
//
//  Created by Mabdu on 17/02/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
// MARK: - ...  ViewController - Vars
class LanguageVC: BaseController {
    @IBOutlet weak var arabicView: UIView!
    @IBOutlet weak var arabicLbl: UILabel!
    @IBOutlet weak var englishView: UIView!
    @IBOutlet weak var englishLbl: UILabel!
    var presenter: LanguagePresenter?
    var router: LanguageRouter?

}

// MARK: - ...  LifeCycle
extension LanguageVC {
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
extension LanguageVC {
    func setup() {
        if Localizer.current == .arabic {
            arabicView.borderWidth = 1
            englishView.borderWidth = 0
            arabicLbl.textColor = R.color.secondColor()
            englishLbl.textColor = R.color.secondTextColor()
        } else {
            arabicView.borderWidth = 0
            englishView.borderWidth = 1
            arabicLbl.textColor = R.color.secondTextColor()
            englishLbl.textColor = R.color.secondColor()
        }
    }
    @IBAction func arabic(_ sender: Any) {
        Localizer.set(language: .arabic)
    }
    @IBAction func english(_ sender: Any) {
        Localizer.set(language: .english)
    }
}
// MARK: - ...  View Contract
extension LanguageVC: LanguageViewContract {
}
