//
//  CategoryDetailsRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/19/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class CategoryDetailsRouter: Router {
    typealias PresentingView = CategoryDetailsVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension CategoryDetailsRouter: CategoryDetailsRouterContract {
    func provider(for provider: Provider?) {
//        if provider?.attributes?.deliveryOption == 0 {
//            guard let scene = R.storyboard.providerDetailsStoryboard.providerDetailsVC() else { return }
//            scene.provider = provider
//            view?.push(scene)
//        } else {
//            guard let scene = R.storyboard.deliveryServiceStoryboard.deliveryServiceVC() else { return }
//            scene.provider = provider
//            scene.delegate = self
//            view?.pushPop(scene)
//        }
    }
    func filter() {
        guard let scene = R.storyboard.categoryFilterStoryboard.categoryFilterVC() else { return }
        //scene.delegate = view
        view?.pushPop(scene)
    }
}

extension CategoryDetailsRouter: DeliveryServiceDelegate {
    func deliveryService(_ delegate: DeliveryServiceDelegate?, for provider: Provider?) {
//        guard let scene = R.storyboard.providerDetailsStoryboard.providerDetailsVC() else { return }
//        scene.provider = provider
//        view?.push(scene)
    }
}
