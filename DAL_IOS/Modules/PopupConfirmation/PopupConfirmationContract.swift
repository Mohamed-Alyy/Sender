//
//  PopupConfirmationContract.swift
//  Mutsawiq
//
//  Created by M.abdu on 11/4/20.
//  Copyright © 2020 com.Rowaad. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol PopupConfirmationPresenterContract: PresenterProtocol {
}
// MARK: - ...  View Contract
protocol PopupConfirmationViewContract: PresentingViewProtocol {
    func openConfirmation(title: String?, btns: [PopupConfirmationView.ModalBtns]?,
    onSkipClosure: PopupConfirmationView.OnClickSkip?,
    onAgreeClosure: PopupConfirmationView.OnClickAgree?)
}
// MARK: - ...  Router Contract
protocol PopupConfirmationRouterContract: Router, RouterProtocol {
}

extension PopupConfirmationViewContract {
    func openConfirmation(title: String?, btns: [PopupConfirmationView.ModalBtns]? = [.skip],
                                  onSkipClosure: PopupConfirmationView.OnClickSkip? = nil,
                                  onAgreeClosure: PopupConfirmationView.OnClickAgree? = nil) {
        let view = self as? POPUPModal
        let scene = PopupConfirmationVC(text: title, btns: btns ?? [.skip])
        scene.onClickSkip = onSkipClosure
        scene.onClickAgree = onAgreeClosure
        view?.pushPop(scene)
    }
}
