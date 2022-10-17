//
//  CategoryDetailFilterCell.swift
//  DAL_IOS
//
//  Created by Mabdu on 04/04/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import UIKit

class CategoryDetailFilterCell: UICollectionViewCell, CellProtocol {
    @IBOutlet weak var containerView: GradientView!
    @IBOutlet weak var titleLbl: UILabel!
    
    var isChecked: Bool = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup() {
//        guard let model = model as? FilterModel else { return }
//        titleLbl.text = model.name
//        if isChecked {
//            titleLbl.textColor = .white
//            if model.id == 0 {
//                containerView.firstColor = UIColor(red: 27/255, green: 172/255, blue: 167/255, alpha: 1)
//                containerView.secondColor = UIColor(red: 98/255, green: 222/255, blue: 217/255, alpha: 1)
//            } else {
//                containerView.firstColor = UIColor(red: 254/255, green: 44/255, blue: 44/255, alpha: 1)
//                containerView.secondColor = UIColor(red: 255/255, green: 122/255, blue: 19/255, alpha: 1)
//            }
//        } else {
//            titleLbl.textColor = R.color.textColor3()
//            containerView.firstColor = .clear
//            containerView.secondColor = .clear
//        }
    }
}
