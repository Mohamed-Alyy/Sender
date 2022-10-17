//
//  CardView.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 03/08/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    @IBInspectable var cornerrRadius: CGFloat = 8
    @IBInspectable var shadowOffSetWidth: CGFloat = 0.1 // 2
    @IBInspectable var shadowOffSetHeight: CGFloat = 1
    @IBInspectable var _borderWidth : CGFloat = 0.0
    @IBInspectable var _shadowOpacity: CGFloat = 0.05
    @IBInspectable var borderColors : UIColor? = UIColor.lightGray.withAlphaComponent(0.3)
    @IBInspectable var topLeft : Bool = false
    @IBInspectable var topRight : Bool = false
    @IBInspectable var bottomLeft : Bool = false
    @IBInspectable var bottomRight : Bool = false
    @IBInspectable var allCorners : Bool = true
     
    override func layoutSubviews() {
        let rectCorners = [
            topLeft ? CACornerMask.layerMinXMinYCorner : nil,
            topRight ? CACornerMask.layerMaxXMinYCorner : nil,
            bottomLeft ? CACornerMask.layerMinXMaxYCorner : nil,
            bottomRight ? CACornerMask.layerMaxXMaxYCorner : nil,
            allCorners ? [CACornerMask.layerMinXMinYCorner, CACornerMask.layerMaxXMinYCorner, CACornerMask.layerMinXMaxYCorner, CACornerMask.layerMaxXMaxYCorner] : nil
            ].compactMap({ $0 })
        var maskedCorners: CACornerMask = []
        rectCorners.forEach { (mask) in maskedCorners.insert(mask) }

//        clipsToBounds = true
        layer.cornerRadius = cornerrRadius
        layer.maskedCorners = maskedCorners
        layer.shadowColor = shadowColor?.cgColor
        
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerrRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(_shadowOpacity)
        layer.borderWidth = _borderWidth
        layer.borderColor = self.borderColors?.cgColor
    }
    
}

