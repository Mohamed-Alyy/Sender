//
//  ProviderHeaderTableviewFilterOrdersCell.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 19/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit


class ProviderHeaderTableviewFilterOrdersCell: UITableViewHeaderFooterView {

    @IBOutlet weak var titileLableHeaderView: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }

    func setHeader(title: String) {
        titileLableHeaderView.text = title
    }

    
}
