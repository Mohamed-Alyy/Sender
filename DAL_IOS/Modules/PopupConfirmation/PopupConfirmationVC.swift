//
//  PopupConfirmationVC.swift
//  Mutsawiq
//
//  Created by M.abdu on 11/4/20.
//  Copyright © 2020 com.Rowaad. All rights reserved.
//

import Foundation
import UIKit
// MARK: - ...  ViewController - Vars
class PopupConfirmationVC: BaseController {
    var presenter: PopupConfirmationPresenter?
    var router: PopupConfirmationRouter?
   
    var containerView: PopupConfirmationView!
    var onClickAgree: PopupConfirmationView.OnClickAgree?
    var onClickSkip: PopupConfirmationView.OnClickSkip?
    var text: String?
    var btns: [PopupConfirmationView.ModalBtns] = []
}

// MARK: - ...  LifeCycle
extension PopupConfirmationVC {
 
    convenience init(text: String? = nil, btns: [PopupConfirmationView.ModalBtns]) {
        self.init()
        self.text = text
        self.btns = btns
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.containerView = PopupConfirmationView(frame: CGRect(x: 0, y: 0, width: view.width-50, height: 0), text: text, btns: btns)
        containerView?.setNibInsideView(view: self)
        self.containerView.onClickAgree = onClickAgree
        self.containerView.onClickSkip = onClickSkip
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
        presenter = nil
        router = nil
    }
}
// MARK: - ...  Functions
extension PopupConfirmationVC {
    func setup() {
    }
}
// MARK: - ...  View Contract
extension PopupConfirmationVC: PopupConfirmationViewContract {
 
}

extension PopupConfirmationVC {
    static func confirmationPOPUP(view: BaseController?, title: String?, btns: [PopupConfirmationView.ModalBtns] = [.skip],
                                  onSkipClosure: PopupConfirmationView.OnClickSkip? = nil,
                                  onAgreeClosure: PopupConfirmationView.OnClickAgree? = nil) {
        let scene = PopupConfirmationVC(text: title, btns: btns)
        scene.onClickSkip = onSkipClosure
        scene.onClickAgree = onAgreeClosure
        view?.pushPop(scene)
    }
}
