//
//  LocationFromMapPresenter.swift
//  Mutsawiq
//
//  Created by M.abdu on 11/5/20.
//  Copyright © 2020 com.Rowaad. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class LocationFromMapPresenter: BasePresenter<LocationFromMapViewContract> {
}
// MARK: - ...  Presenter Contract
extension LocationFromMapPresenter: LocationFromMapPresenterContract {
}
// MARK: - ...  Example of network response
extension LocationFromMapPresenter {
    func fetchResponse<T: LocationFromMapModel>(response: NetworkResponse<T>) {
        switch response {
            case .success(_):
                break
            case .failure(_):
                break
        }
    }
}
