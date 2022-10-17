//
//  SliderCollectionCell.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/18/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import UIKit

class SliderCollectionCell: UICollectionViewCell, CellProtocol {
    @IBOutlet weak var imageCell: UIImageView!
    
    func setup() {
        guard let model = model as? AdsResult else { return }
        imageCell.setImage(url: model.pic)
        imageCell.UIViewAction {
            Common().openUrl(text: model.link)
        }
    }
}
