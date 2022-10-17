//
//  RoundedButton.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 12/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    @IBInspectable var shadowOffSetWidth: CGFloat = 0.5
    @IBInspectable var shadowOffSetHeight: CGFloat = 0.5
    @IBInspectable var shadowOpacityX: CGFloat = 0.5
    @IBInspectable var shadowColorX = UIColor.gray
    @IBInspectable var cornerRadiusX: CGFloat = 20 {
        didSet {
            refreshCorners(value: cornerRadiusX)
        }
    }
    @IBInspectable var borderWidthX: CGFloat = 0 {
        didSet {
            refreshBorder(width: borderWidthX)
        }
    }
    @IBInspectable var borderColorX: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) {
        didSet {
            refreshBorderColor(color: borderColorX.cgColor)
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        refreshCorners(value: cornerRadiusX)
        refreshBorderColor(color: borderColorX.cgColor)
        refreshBorder(width: borderWidthX)
    }
    
    func refreshBorder(width: CGFloat) {
        layer.borderWidth = width
    }
    
    func refreshBorderColor(color : CGColor) {
        layer.borderColor = color
    }
    
    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
        layer.shadowColor = shadowColorX.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        layer.shadowOpacity = Float(shadowOpacityX)
    }
    
}
