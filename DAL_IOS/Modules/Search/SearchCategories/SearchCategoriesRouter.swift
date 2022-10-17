//
//  SearchCategoriesRouter.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 19/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import Foundation


// MARK: - ...  Router
class SearchCategoriesRouter: Router {
    typealias PresentingView = SearchCategoriesVC
    weak var view: PresentingView?
    deinit {
        self.view = nil
    }
}

extension SearchCategoriesRouter: SearchCategoriesRouterContract {
    func filter(with options: FilterOptionModel.DataClass?) {
        guard let scene = R.storyboard.searchFilterStoryboard.searchFilterVC() else { return }
//        scene.options = options
        scene.delegate = view
        view?.pushPop(scene)
    }
    func provider(for provider: ProvidersResult?) {
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
        guard let scene = R.storyboard.providerDetailsStoryboard.providerDetailsVC() else { return }
        scene.provider = provider
        view?.push(scene)
    }
    
    func openMap() {
        guard let scene = R.storyboard.locationFromMapStoryboard.locationFromMapVC() else { return }
        scene.delegate = view
        self.view?.push(scene)
    }
}
extension SearchCategoriesRouter: DeliveryServiceDelegate {
    func deliveryService(_ delegate: DeliveryServiceDelegate?, for provider: Provider?) {
//        guard let scene = R.storyboard.providerDetailsStoryboard.providerDetailsVC() else { return }
//        scene.provider = provider
//        view?.push(scene)
    }
}
