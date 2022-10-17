//
//  ExUIViewController.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 02/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
}
