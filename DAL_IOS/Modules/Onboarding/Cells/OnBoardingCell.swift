//
//  OnBoardingCell.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import UIKit

protocol OnBoardingCellDelegate: class {
    func onBoardingCell(_ cell: OnBoardingCell, next for: Bool)
    func onBoardingCell(_ cell: OnBoardingCell, start for: Bool)
}
class OnBoardingCell: UICollectionViewCell, CellProtocol {
    @IBOutlet weak var containerView: GradientView!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var welcomeImage: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var startBtn: GradientButton!
    @IBOutlet weak var nextView: UIView!
    
    weak var delegate: OnBoardingCellDelegate?
    func setup() {
        if path == 2 {
            nextView.isHidden = true
            startBtn.isHidden = false
        } else {
            nextView.isHidden = false
            startBtn.isHidden = true
        }
        containerView.firstColor = .clear
        containerView.secondColor = .clear
        containerView.firstColor = R.color.whiteColor() ?? .clear
        countLbl.text = "0\(indexPath() + 1)"
        if path == 0 {
            titleLbl.text = "Application Features".localized
            descLbl.text = "نص تعبيري عن العنوان الترحيبي او وصف ما يخص خصائص التطبيق"
            welcomeImage.image = UIImage(named: "onBoarding1")
        } else if path == 1 {
            titleLbl.text = "Application Features".localized
            descLbl.text = "نص تعبيري عن العنوان الترحيبي او وصف ما يخص خصائص التطبيق"
            welcomeImage.image = UIImage(named: "onBoarding2")
        } else {
            titleLbl.text = "Application Features".localized
            descLbl.text = "نص تعبيري عن العنوان الترحيبي او وصف ما يخص خصائص التطبيق"
            welcomeImage.image = UIImage(named: "onBoarding3")
        }
    }
    @IBAction func next(_ sender: Any) {
        delegate?.onBoardingCell(self, next: true)
    }
    @IBAction func start(_ sender: Any) {
        delegate?.onBoardingCell(self, start: true)
    }
}
