//
//  ExtraMealCell.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/25/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import UIKit

protocol ExtraMealCellDelegate: AnyObject {
    func extraMealCell(for cell: ExtraMealCell)
}
class ExtraMealCell: UITableViewCell, CellProtocol {

    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var removeBtn: UIButton!
    @IBOutlet weak var removeView: GradientView!
    @IBOutlet weak var stockLbl: UILabel!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var bottomStackView: UIStackView!
    
    weak var delegate: ExtraMealCellDelegate?
    func setup() {
        guard let model = model as? AdditionsModel else { return }
        imageCell.setImage(url: model.image)
        titleLbl.text = "\(model.name ?? "")   (\(model.quantity ?? 0))"
        let price = (model.price ?? model.peicePrice ?? "0")
        priceLbl.text = "\(price) \("SAR".localized)"
        stockLbl.text = "\(model.stock ?? 0)" + " " + "Stock".localized
        caloriesLbl.text = "\(model.calories ?? 0) \("calory".localized)"
    }
    
    func setupExtraInOrder() {
        removeBtn.isHidden = true
        removeView.isHidden = true
        guard let model = model as? AdditionsModel else { return }
        imageCell.setImage(url: model.image)
        titleLbl.text = "\(model.name ?? "")   (\(model.quantity ?? 0))"
        let price = (model.price ?? "0")
        priceLbl.text = "\(price) \("SAR".localized)"
    }
    @IBAction func remove(_ sender: Any) {
        delegate?.extraMealCell(for: self)
    }
}
