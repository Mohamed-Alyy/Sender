//
//  MealDetailsRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/25/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class MealDetailsRouter: Router {
    typealias PresentingView = MealDetailsVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension MealDetailsRouter: MealDetailsRouterContract {
    func extras() {
        guard let scene = R.storyboard.mealExtrasStoryboard.mealExtrasVC() else { return }
        scene.meal = view?.meal
        scene.delegate = view
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
