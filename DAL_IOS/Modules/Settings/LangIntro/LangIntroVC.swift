//
//  LangIntroVC.swift
//  DAL_Provider
//
//  Created by Mabdu on 03/03/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class LangIntroVC: BaseController {
    @IBOutlet weak var arabicView: UIView!
    @IBOutlet weak var arabicLbl: UILabel!
    @IBOutlet weak var englishView: UIView!
    @IBOutlet weak var englishLbl: UILabel!
    var presenter: LangIntroPresenter?
    var router: LangIntroRouter?
    var lang: Languages = Localizer.current
    
}

// MARK: - ...  LifeCycle
extension LangIntroVC {
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
extension LangIntroVC {
    func setup() {
        if lang == .arabic {
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
        lang = .arabic
        setup()
        Localizer.set(language: lang)
    }
    @IBAction func english(_ sender: Any) {
        lang = .english
        setup()
        Localizer.set(language: lang)
    }
    @IBAction func save(_ sender: Any) {
        UserDefaults.standard.setValue(true, forKey: "LANG_INTRO")
        let scene = R.storyboard.onBoardingStoryboard().instantiateInitialViewController()
        let delegate = UIApplication.shared.delegate as? AppDelegate
        delegate?.window?.rootViewController = scene
    }
}
// MARK: - ...  View Contract
extension LangIntroVC: LangIntroViewContract {
}
