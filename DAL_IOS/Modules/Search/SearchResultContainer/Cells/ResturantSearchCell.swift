//
//  ResturantSearchCell.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/21/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import UIKit

class ResturantSearchCell: UITableViewCell, CellProtocol {
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    func setup() {
        guard let model = model as? Provider else { return }
        imageCell.setImage(url: model.avatar)
        titleLbl.text = model.name
        descLbl.text = model.attributes?.detailsAr
    }
    
}
