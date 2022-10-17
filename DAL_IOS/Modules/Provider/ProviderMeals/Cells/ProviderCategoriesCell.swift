//
//  ProviderCategoriesCell.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 06/09/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

class ProviderCategoriesCell: UICollectionViewCell {

    
    @IBOutlet private weak var cardView: UIView!
    @IBOutlet private weak var titleLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configuraCell(_ title: String?, isSelected: Bool? = false){
        let isSelected = isSelected ?? false
        let title = title ?? ""
        cardView.backgroundColor = isSelected ? R.color.mainColor() ?? .clear : .clear
        titleLb.textColor = isSelected ? UIColor.white : UIColor.black
        titleLb.text = title
    }

}
