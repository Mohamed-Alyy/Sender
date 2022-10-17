//
//  OrderDetailsRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class ReservationDetailsRouter: Router {
    typealias PresentingView = ReservationDetailsVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension ReservationDetailsRouter: ReservationDetailsRouterContract {
    func dismiss() {
        view?.delegate?.reservationDetails(view?.delegate)
        view?.dismiss(animated: true, completion: nil)
    }
    func reserveTable(for bookModel: ReservationTableModel?) {
        guard let scene = R.storyboard.reservationTableStoryboard.reservationTableVC() else { return }
        scene.delegate = self
        scene.bookModel = bookModel
        //scene.provider = view?.provider
        view?.pushPop(scene)
    }
    
}
extension ReservationDetailsRouter: ReservationTableDelegate {
    func reservationTable(_ delegate: ReservationTableDelegate?, for book: ReservationTableModel?) {
        dismiss()
    }
}
