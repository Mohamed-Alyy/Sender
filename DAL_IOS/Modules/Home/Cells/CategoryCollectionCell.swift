//
//  CategoryCollectionCell.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/18/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell, CellProtocol {
    @IBOutlet weak var backgroundGradientView: UIView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var countLbl: UILabel!
    
    var categoriesBackgroundColor: [String: [UIColor: UIColor]] = [
        "blue": [UIColor(named: "BlueGradient1")!:UIColor(named: "BlueGradient2")!],
        "orange": [UIColor(named: "OrangGradient1")!:UIColor(named: "OrangGradient2")!],
        "red": [UIColor(named: "RedGradient1")!:UIColor(named: "RedGradient2")!]
    ]
    
    func setup() {
        guard let model = model as? CategoriesResult else { return }
        titleLbl.text = model.title
        countLbl.text = "\("More than".localized) \(model.providers_count ?? 0) \("resturant".localized)"
        
        switch model.getType() {
            case .Resutrant:
            guard let color = categoriesBackgroundColor["red"]?.first else {return}
            backgroundGradientView.applyGradient(colours: [color.key,color.value])
            case .Juice:
            guard let color = categoriesBackgroundColor["blue"]?.first else {return}
            backgroundGradientView.applyGradient(colours: [color.key,color.value])
            default:
            let keys: [String] = ["red", "blue", "orange"]
            let value = keys.randomElement() ?? "orange"
            guard let color = categoriesBackgroundColor[value]?.first else {return}
            backgroundGradientView.applyGradient(colours: [color.key,color.value]) 
        }
        iconImage.setImage(url: model.image)
    }
}
