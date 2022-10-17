//
//  MealExtraEditCell.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/26/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import UIKit

protocol MealExtraEditDelegate: AnyObject {
    func mealExtraEdit(for cell: MealExtraEditCell, quantity: Int?)
}
class MealExtraEditCell: UITableViewCell, CellProtocol {
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var currancyLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var quantityView: QuantityView!
    @IBOutlet weak var isSelectedView: UIView!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var stockLbl: UILabel!
    @IBOutlet weak var caloriesLbl: UILabel!
    @IBOutlet weak var outOfStockView: UIView!
    
    weak var delegate: MealExtraEditDelegate?
    var additionsModel: AdditionsModel?
    func setup() {
        guard let model = model as? AdditionsModel else { return }
        additionsModel = model
        stockLbl.text = "\(model.stock ?? 0)" + " " + "Stock".localized
        caloriesLbl.text = "\(model.calories ?? 0) \("calory".localized)"
        imageCell.setImage(url: model.image)
        imageCell.isHidden = true
        titleLbl.text = model.name
        priceLbl.text = model.price ?? "0"
        descLbl.text = model.datumDescription
        if model.isChecked == true && model.quantity ?? 0 > 0 {
            isSelectedView.isHidden = false
            selectBtn.isHidden = true
        } else {
            isSelectedView.isHidden = true
            selectBtn.isHidden = false
        }
        quantityView.delegate = self
        quantityView.dataSource = self
        let stock = model.stock ?? 0
        outOfStockView?.isHidden = stock != 0
        quantityView?.isHidden = stock == 0
    }
    @IBAction func selectExtra(_ sender: Any) {
    }
}

extension MealExtraEditCell: QuantityViewDelegate, QuantityViewDataSource {
    func quantityView(_ view: QuantityView?) -> QuantityModel? {
        return model as? QuantityModel
    }
    
    func quantityView(_ view: QuantityView?, didChange item: QuantityModel?) {
        delegate?.mealExtraEdit(for: self, quantity: item?.quantity)
    }
}
