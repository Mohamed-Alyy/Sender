//
//  TagModel.swift
//  DAL_Provider
//
//  Created by M.abdu on 1/5/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

protocol FilterModel {
    var name: String? { get set }
    var id: Int? { get set }
    var checked: Bool? { get set }
}
