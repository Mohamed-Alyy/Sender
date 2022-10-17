//
//  LocationFromMapRouter.swift
//  Mutsawiq
//
//  Created by M.abdu on 11/5/20.
//  Copyright © 2020 com.Rowaad. All rights reserved.
//

import Foundation

// MARK: - ...  Router
class LocationFromMapRouter: Router {
    typealias PresentingView = LocationFromMapVC
    weak var view: PresentingView?
    deinit {    
        self.view = nil
    }
}

extension LocationFromMapRouter: LocationFromMapRouterContract {
    func backToLocationRequestWithSuccess() {
        self.view?.delegate?.saveLocation(lat: self.view?.lat, lng: self.view?.lng, address: self.view?.snippetAddress)
        self.view?.navigationController?.popViewController(animated: true)
         
    }
    func backToLocationRequestWithFail() {
        self.view?.dismiss(animated: true, completion: {
            self.view?.delegate?.didFailLocation()
        })
    }
}
