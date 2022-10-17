//
//  OrderDetailsPresenter.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/11/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter
class ReservationDetailsPresenter: BasePresenter<ReservationDetailsViewContract> {
}
// MARK: - ...  Presenter Contract
extension ReservationDetailsPresenter: ReservationDetailsPresenterContract {
    func fetchReservation(reservationID: Int?) {
        //new, processing, finished, canceled
        let method = NetworkConfigration.EndPoint.endPoint(point: .reservation, paramters: [reservationID ?? 0])
        NetworkManager.instance.request(method, type: .get, ReservationDetailsModel.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    self?.view?.didFetchReservation(reservation: model?.data)
                case .failure:
                    self?.view?.stopLoading()

            }
        }
    }
    func cancelReservation(for reservation: ReservationsModel.Datum?) {
        if UserRoot.token() == nil {
            UserRoot.authroize()
            return
        }
        NetworkManager.instance.paramaters["reservation_id"] = reservation?.id ?? 0
        NetworkManager.instance.request(.refuseReservation, type: .post, BaseModel<String>.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    self?.view?.didCancel()
                case .failure:
                    break
            }
        }
    }
    func rateReservation(for reservation: ReservationsModel.Datum?, rate: Double?, comment: String?) {
        if UserRoot.token() == nil {
            UserRoot.authroize()
            return
        }
        
        NetworkManager.instance.paramaters["reservation_id"] = reservation?.id
        NetworkManager.instance.paramaters["rating"] = rate
        NetworkManager.instance.paramaters["comment"] = comment
        NetworkManager.instance.paramaters["rateable_type"] = "reservation"
        NetworkManager.instance.request(.rate, type: .post, BaseModel<String>.self) { [weak self] (response) in
            switch response {
                case .success(let model):
                    self?.view?.didRated()
                case .failure:
                    break
            }
        }
    }
}
