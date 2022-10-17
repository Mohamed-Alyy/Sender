//
//  ProviderMoreMenuCell.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 11/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

class ProviderMoreMenuCell: UITableViewCell {

    @IBOutlet private weak var iconIV: UIImageView!
    @IBOutlet private weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupViews(for type: ProviderMenuItemType?) {
        guard let type = type else {
            return
        } 
        iconIV.image = UIImage(named: type.image)
        titleLbl.text = type.title
        titleLbl.textColor = UIColor.black
    }
    
}
