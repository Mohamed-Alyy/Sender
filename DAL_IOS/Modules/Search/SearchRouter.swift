//
//  SearchRouter.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/18/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class SearchRouter: Router {
    typealias PresentingView = SearchVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension SearchRouter: SearchRouterContract {
    func filter(with options: FilterOptionModel.DataClass?) {
        guard let scene = R.storyboard.searchFilterStoryboard.searchFilterVC() else { return }
//        scene.options = options
        scene.delegate = view
        view?.pushPop(scene)
    }
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
    
    func openMap() {
        guard let scene = R.storyboard.locationFromMapStoryboard.locationFromMapVC() else { return }
        scene.delegate = view
        self.view?.push(scene)
    }
}
extension SearchRouter: DeliveryServiceDelegate {
    func deliveryService(_ delegate: DeliveryServiceDelegate?, for provider: Provider?) {
//        guard let scene = R.storyboard.providerDetailsStoryboard.providerDetailsVC() else { return }
//        scene.provider = provider
//        view?.push(scene)
    }
}
