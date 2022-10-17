//
//  ReservationsModel.swift
//  DAL_Provider
//
//  Created by Mabdu on 28/02/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ReservationModel
struct ReservationsModel: Codable {
    let status: Bool?
    let data: [Datum]?
    
    // MARK: - Datum
    struct Datum: Codable {
        let id: Int?
        let providerID: Int?
        let providerName: String?
        let providerImg: String?
        let providerAddress: String?
        let userID: String?
        let userName: String?
        let userImg: String?
        let userAddress: String?
        let qty: Int?
        let reservationTime, reservationDate: String?
        //let featureID: Int?
        let features: [FilterOptionModel.Feature]?
        let status: Int?
        let type: String?
        let statusText: String?
        let date, time: String?
        let remaining: String?
        let refuseal: String?
        let isRated: Int?
        enum CodingKeys: String, CodingKey {
            case id
            case providerID = "provider_id"
            case providerName = "provider_name"
            case providerImg = "provider_img"
            case providerAddress = "provider_address"
            case userName = "user_name"
            case userImg = "user_img"
            case userID = "user_id"
            case userAddress = "user_address"
            case qty
            case reservationTime = "reservation_time"
            case reservationDate = "reservation_date"
            //case featureID = "feature_id"
            case features = "feaures"
            case status, type
            case statusText = "status_text"
            case date, time, remaining
            case refuseal
            case isRated
        }
    }
}
