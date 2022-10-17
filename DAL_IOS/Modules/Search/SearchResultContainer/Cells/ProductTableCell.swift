//
//  ProductTableCell.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/18/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import UIKit

class ProductTableCell: UITableViewCell, CellProtocol {
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var resturantLbl: UILabel!
    @IBOutlet weak var categoryLbl: UILabel!
    @IBOutlet weak var currencyLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var heartBtn: UIButton!
  
    weak var delegate: FavoriteCellDelegate?
    func setup() {
        guard let model = model as? Meal else { return }
        imageCell.setImage(url: model.img)
        titleLbl.text = model.name
        resturantLbl.text = model.providerName
        categoryLbl.text = model.subcategoryName
        priceLbl.text = model.price ?? "0"
        
        if model.liked() {
            heartBtn.setImage(#imageLiteral(resourceName: "Group 2657"), for: .normal)
            heartBtn.imageEdgeInsets.top = -10
        } else {
            heartBtn.setImage(#imageLiteral(resourceName: "Iconly-Light-Heart"), for: .normal)
            heartBtn.imageEdgeInsets.top = 0
        }
        
    }
    @IBAction func favorite(_ sender: Any) {
        guard var model = model as? Meal else { return }
        model.like()
        delegate?.favoriteCell(for: self)
    }
}
