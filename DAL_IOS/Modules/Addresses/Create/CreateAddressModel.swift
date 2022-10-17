//
//  CreateAddressModel.swift
//  DAL_IOS
//
//  Created by M.abdu on 2/7/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
class CreateAddressModel: Codable {
    let data: AddressesModel.Datum?
}

// MARK: - CitiesModel
struct CitiesModel: Codable {
    let status: Bool?
    let data: [Datum]?
    
    // MARK: - Datum
    struct Datum: Codable {
        let id: Int?
        let name: String?
        let areas: [Area]?
    }

    // MARK: - Area
    struct Area: Codable {
        let id: Int?
        let name: String?
    }

}
