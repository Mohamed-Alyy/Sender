//
//  ProviderCategoriesMealCell.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 07/09/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

class ProviderCategoriesMealCell: UITableViewCell, CellProtocol {

    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var pointLbl: UILabel!
    @IBOutlet weak var currencyLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup() {
        guard let model = model as? ProviderCategoriesMealsDatum else { return }
        imageCell.setImage(url: model.image)
        titleLbl.text = model.name
        caloriesLbl.text = "\(model.calories ?? 0) \("calory".localized)"
        pointLbl.text = "0" + " " + "Loyalty Points".localized
        priceLbl.text = model.price ?? "0"
    }
    
}
