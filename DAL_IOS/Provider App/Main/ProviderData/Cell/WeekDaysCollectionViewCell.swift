//
//  WeekDaysCollectionViewCell.swift
//  DAL_IOS
//
//  Created by Mohamed Ali on 21/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

protocol WorkDaysDelegateProtocol{
    func didXbuttonTapped(cellRow: Int)
}

class WeekDaysCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bacView: UIView!{
        didSet{
            bacView.layer.cornerRadius = 20
            bacView.backgroundColor = .systemGray6
        }
    }
    @IBOutlet weak var dayTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    var currentCell = 0
    var delegate: WorkDaysDelegateProtocol?
    
    
    @IBAction func xButtonPressed(_ sender: UIButton) {
        delegate?.didXbuttonTapped(cellRow: currentCell)
    }
    
}
