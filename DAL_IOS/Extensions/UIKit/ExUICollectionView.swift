//
//  ExUICollectionView.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 12/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

extension UICollectionView
{
    // MARK: Properties
     
    
    // MARK: Methods
    
    func registerHeader<T>(header: T.Type) where T: UICollectionReusableView
    {
        register(header.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: header.identifier)
    }
    
    func register<T>(cell: T.Type) where T: UICollectionViewCell
    {
        register(cell.nib, forCellWithReuseIdentifier: cell.identifier)
    }
    
    func dequeue<Cell: UICollectionViewCell>(indexPath: IndexPath) -> Cell
    {
        guard let cell = dequeueReusableCell(withReuseIdentifier: "\(Cell.self)", for: indexPath) as? Cell
        else { fatalError("Error in cell") }
        return cell
    }
    
    func fitHeightToContent(view: UIView, heightConstraint: NSLayoutConstraint) {
        self.reloadData()
        heightConstraint.constant = self.collectionViewLayout.collectionViewContentSize.height
        view.setNeedsLayout() //Or self.view.layoutIfNeeded()
        
    }
}
