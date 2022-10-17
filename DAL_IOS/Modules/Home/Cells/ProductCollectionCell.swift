//
//  ProductCollectionCell.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/18/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import UIKit

class ProductCollectionCell: UICollectionViewCell, CellProtocol {
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var resturantLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var currencyLbl: UILabel!
    
    func setup() {
        guard let model = model as? ProviderCategoriesMealsDatum else { return }
        imageCell.setImage(url: model.image)
        nameLbl.text = model.name
        resturantLbl.text = model.provider?.name
        priceLbl.text = model.price ?? "0"
    }
}
