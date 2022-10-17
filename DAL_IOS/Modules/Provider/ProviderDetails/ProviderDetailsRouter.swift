//
//  ProviderDetailsRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/21/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class ProviderDetailsRouter: Router {
    typealias PresentingView = ProviderDetailsVC
    weak var view: PresentingView?
    var subCategory: Provider.SubCategory?
    deinit {
        self.view = nil
    }
}

extension ProviderDetailsRouter: ProviderDetailsRouterContract {
    func rates() {
        guard let scene = R.storyboard.providerRatesStoryboard.providerRatesVC() else { return }
        scene.provider = view?.provider
        scene.rates = view?.rates ?? []
        view?.push(scene)
    }
    
    func requestMeal(with category: Provider.SubCategory? = nil) {
        if category != nil {
//            subCategory = category
//            guard let scene = R.storyboard.reservationTypeStoryboard.reservationTypeVC() else { return }
//            scene.delegate = self
//            view?.pushPop(scene)
            guard let scene = R.storyboard.providerMealsStoryboard.providerMealsVC() else { return }
            scene.provider = view?.provider
//            scene.subCategory = category
            view?.push(scene)
        } else {
            guard let scene = R.storyboard.providerMealsStoryboard.providerMealsVC() else { return }
//            scene.provider = view?.provider
            view?.push(scene)
        }
    }
    func reserveTable() {
//        guard let scene = R.storyboard.reservationTableStoryboard.reservationTableVC() else { return }
//        scene.delegate = self
//        scene.provider = view?.provider
//        view?.pushPop(scene)
    }
    func didReservedTable(for book: ReservationTableModel?) {
        guard let scene = R.storyboard.reservationTableDoneStoryboard.reservationTableDoneVC() else { return }
        scene.delegate = self
        scene.book = book
        view?.pushPop(scene)
    }
    
    func cart(providerId :Int) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.050) {
            guard let scene = R.storyboard.cartStoryboard.cartVC() else { return }
            scene.providerId = providerId
            self.view?.push(scene)
        }
    }
}

extension ProviderDetailsRouter: ReservationTypeDelegate {
    func reservationType(_ delegate: ReservationTypeDelegate?, meal: Bool) {
//        guard let scene = R.storyboard.providerMealsStoryboard.providerMealsVC() else { return }
//        scene.provider = view?.provider
//        scene.subCategory = subCategory
//        view?.push(scene)
    }
    func reservationType(_ delegate: ReservationTypeDelegate?, reservation: Bool) {
//        guard let scene = R.storyboard.providerMealsStoryboard.providerMealsVC() else { return }
//        scene.provider = view?.provider
//        scene.subCategory = subCategory
//        view?.push(scene)
    }
}


extension ProviderDetailsRouter: ReservationTableDelegate {
    func reservationTable(_ delegate: ReservationTableDelegate?, for book: ReservationTableModel?) {
        didReservedTable(for: book)
    }
}

extension ProviderDetailsRouter: ReservationDoneDelegate {
    func reservationDone(_ delegate: ReservationDoneDelegate?) {
        guard let scene = R.storyboard.reservationsStoryboard.reservationsVC() else { return }
        view?.push(scene)
    }
}
