//
//  TagCollectionCell.swift
//  DAL_Provider
//
//  Created by M.abdu on 1/4/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import UIKit

protocol TagCollectionCellDelegate: class {
    func removeTag(path: Int)
}
class TagCollectionCell: UICollectionViewCell, CellProtocol {
    @IBOutlet weak var tagNameLbl: UILabel!
    
    weak var delegate: TagCollectionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setup() {
        
    }
    @IBAction func remove(_ sender: Any) {
        delegate?.removeTag(path: path ?? 0)
    }
}
