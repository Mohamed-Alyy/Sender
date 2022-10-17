//
//  RouterProtocol.swift
//  BaseIOS
//
//  Created by M.abdu on 10/18/20.
//  Copyright © 2020 com. All rights reserved.
//

import Foundation
// MARK: - ...  Router Protocol
// All Router must implement this protocol
protocol RouterProtocol {
    // Generic Type for any view
    associatedtype PresentingView
    var view: PresentingView? { get set }
}
