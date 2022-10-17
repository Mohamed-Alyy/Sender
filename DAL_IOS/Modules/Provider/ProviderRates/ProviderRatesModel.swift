//
//  ProviderRatesModel.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/24/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

struct ProviderRatesModel: Codable {
    let status: Bool?
    let data: [Provider.Rate]?
}
