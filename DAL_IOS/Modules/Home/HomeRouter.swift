//
//  HomeRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/29/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class HomeRouter: Router {
    typealias PresentingView = HomeVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension HomeRouter: HomeRouterContract {
    func category(for category: CategoriesResult) {
        guard let scene = R.storyboard.categoryDetailsStoryboard.categoryDetailsVC() else { return }
        scene.category = category
        view?.push(scene)
    }
    func product(for mealID: Int?) {
        guard let scene = R.storyboard.mealDetailsStoryboard.mealDetailsVC() else { return }
        scene.mealID = mealID
        view?.push(scene)
    }
    func search(text: String?,for category: CategoriesResult?) {
        let scene = SearchCategoriesVC.loadFromNib()
        scene.text = text
        scene.category = category
        view?.push(scene)
    }
    
    func openProviderCart() {
        let scene = ProviderCartListVC.loadFromNib()
        view?.push(scene)
    }
    
    func rateOrder() {
        guard let orderID = UserRoot.fetchUser()?.notRatedOrder else { return }
        guard let scene = R.storyboard.orderDetailsStoryboard.orderDetailsVC() else { return }
        scene.tab = .completed
        scene.orderID = orderID
        scene.forceRate = true
        view?.pushPop(scene)
    }
}
