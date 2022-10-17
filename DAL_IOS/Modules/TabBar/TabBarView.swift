//
//  TabBarView.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/18/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class TabBarWithCorners: UITabBar {
    private var shapeLayer: CALayer?
    override func draw(_ rect: CGRect) {
        addShape()
    }
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.gray.withAlphaComponent(0.1).cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.shadowColor = R.color.shadowColor()?.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: -3)
        shapeLayer.shadowOpacity = 0.8
        shapeLayer.shadowRadius = 12
        shapeLayer.shadowPath =  UIBezierPath(roundedRect: bounds, cornerRadius: 20).cgPath
        
        
        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.shapeLayer = shapeLayer
    }
    
    private func createPath() -> CGPath {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: 20, height: 0.0))
        
        return path.cgPath
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.isTranslucent = true
        var tabFrame            = self.frame
        tabFrame.size.height    = 65 + (UIApplication.keyWindow?.safeAreaInsets.bottom ?? CGFloat.zero)
        tabFrame.origin.y       = self.frame.origin.y +   ( self.frame.height - 65 - (UIApplication.keyWindow?.safeAreaInsets.bottom ?? CGFloat.zero))
        self.layer.cornerRadius = 20
        self.frame            = tabFrame
        
        
        
        self.items?.forEach({ $0.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -5.0) })
    }
    
}
