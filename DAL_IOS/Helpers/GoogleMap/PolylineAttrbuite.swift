//
//  MapProtocolHelper.swift
//  Tafran
//
//  Created by mohamed abdo on 5/15/18.
//  Copyright © 2018 mohamed abdo. All rights reserved.
//
import UIKit
import CoreData

struct PolylineAttrbuite {
    var color: UIColor!
    var width: CGFloat!
}

protocol PolylineDataSource: class {
    func polyline() -> PolylineAttrbuite
}
