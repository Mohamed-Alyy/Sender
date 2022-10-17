//
//  SearchFilterModel.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/19/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Entity
class SearchFilterModel: Codable {
}

// MARK: - Welcome
struct AreasModel: Codable {
    let data: [AreasDatum]?
}

// MARK: - Datum
struct AreasDatum: Codable, FilterModel {
    var checked: Bool?
    var id: Int?
    var title, name: String?
    let cities: [CitiesListModel]?
    let lang: String?
}

struct CitiesListByIdModel: Codable {
    var data: [CitiesListModel]?
}


struct CitiesListModel: Codable, FilterModel {
    var checked: Bool?
    var id: Int?
    var title, name: String?
    let lang: String?
}

 
