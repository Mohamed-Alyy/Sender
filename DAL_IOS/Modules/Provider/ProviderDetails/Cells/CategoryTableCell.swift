//
//  CategoryTableCell.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/24/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import UIKit

class CategoryTableCell: UITableViewCell, CellProtocol {
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var countLbl: UILabel!
    
    func setup() {
        guard let model = model as? ProviderCategoriesDatum else { return }
        backgroundImage.setImage(url: model.image)
        titleLbl.text = model.title
        countLbl.text = "\("Available type".localized) \(model.productsCount ?? 0)"
    }
}
