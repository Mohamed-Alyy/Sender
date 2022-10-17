//
//  AdditionsTableViewCell.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 08/09/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

protocol AdditionsTableViewCellProtocol: AnyObject {
    func didTappedDeleteAdditions(_ additionsModel: AdditionsModel)
}

class AdditionsTableViewCell: UITableViewCell,CellProtocol {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    weak var additionsDelegate: AdditionsTableViewCellProtocol?
    
    var additionsModel: AdditionsModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup() {
        guard let model = model as? AdditionsModel else { return }
        additionsModel = model
        titleLbl.text = model.name
        priceLbl.text = model.peicePrice ?? "0"
        if Localizer.current == .arabic {
            titleLbl.text = (model.name ?? "") + " x \(model.quantity ?? 0) "
        } else {
            titleLbl.text = "\(model.quantity ?? 0) x " + (model.name ?? "")
        }
    }
    
    @IBAction func didTappedDelete(_ sender: UIButton){
        guard let additionsModel = additionsModel else {
            return
        }

        additionsDelegate?.didTappedDeleteAdditions(additionsModel)
    }
    
}
