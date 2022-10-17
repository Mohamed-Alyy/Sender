//
//  FaqCell.swift
//  DAL_Provider
//
//  Created by Mabdu on 02/03/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import UIKit

class FaqCell: UITableViewCell, CellProtocol {
    @IBOutlet weak var countView: GradientView!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var answerLbl: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    static var COUNT_COLOR = 1
    var isExpanded: Bool = false
    
    func setup() {
        guard let model = model as? FaqModel.Datum else { return }
        titleLbl.text = model.question
        setupUI()
        setupExpand()
    }
    func setupExpand() {
        guard let model = model as? FaqModel.Datum else { return }
        if isExpanded {
            answerLbl.text = model.answer
            topConstraint.constant = 40
            bottomConstraint.constant = 30
        } else {
            answerLbl.text = nil
            topConstraint.constant = 15
            bottomConstraint.constant = 0
        }
    }
    func setupUI() {
        countLbl.text = ((path ?? 0) + 1).string
        switch FaqCell.COUNT_COLOR {
        case 1:
            countView.firstColor = R.color.mainColor() ?? .clear
            countView.secondColor = R.color.mainColor() ?? .clear
            countView.thirdColor = R.color.secondColor() ?? .clear
            FaqCell.COUNT_COLOR += 1
        case 2 :
            countView.firstColor = R.color.textColorBlue() ?? .clear
            countView.secondColor = R.color.textColorBlue() ?? .clear
            countView.thirdColor = UIColor(red: 50/255, green: 195/255, blue: 190/255, alpha: 1)
            FaqCell.COUNT_COLOR += 1
        case 3 :
            countView.firstColor = UIColor(red: 250/255, green: 109/255, blue: 0/255, alpha: 1)
            countView.secondColor = UIColor(red: 250/255, green: 109/255, blue: 0/255, alpha: 1)
            countView.thirdColor = UIColor(red: 255/255, green: 146/255, blue: 48/255, alpha: 1)
            FaqCell.COUNT_COLOR += 1
        case 4 :
            countView.firstColor = UIColor(red: 255/255, green: 219/255, blue: 93/255, alpha: 1)
            countView.secondColor = UIColor(red: 255/255, green: 219/255, blue: 93/255, alpha: 1)
            countView.thirdColor = UIColor(red: 251/255, green: 198/255, blue: 11/255, alpha: 1)
            FaqCell.COUNT_COLOR = 1
        default:
            break
                
        }
    }
}
