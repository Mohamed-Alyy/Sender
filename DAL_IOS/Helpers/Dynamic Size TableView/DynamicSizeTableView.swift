//
//  DynamicSizeTableView.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 13/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

public class DynamicSizeTableView: UITableView
{
    override public func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }

    override public var intrinsicContentSize: CGSize {
        return contentSize
    }
}
