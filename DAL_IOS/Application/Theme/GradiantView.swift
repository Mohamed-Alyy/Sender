//
//  GradientView.swift
//  Aura
//
//  Created by Egor Sakhabaev on 23.07.17.
//  Copyright © 2017 Egor Sakhabaev. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var firstColor: UIColor = R.color.mainColor() ?? .clear {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var secondColor: UIColor = R.color.secondColor() ?? .clear {
        didSet {
            updateView()
        }
    }
    @IBInspectable var thirdColor: UIColor = UIColor.clear {
        didSet {
            updateView()
        }
    }
    @IBInspectable var isHorizontal: Bool = true {
        didSet {
            updateView()
        }
    }
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    
    
    func updateView() {
        self.applyGradient(colours: [firstColor,secondColor])
//        let layer = self.layer as? CAGradientLayer
//        if thirdColor == .clear {
//            layer?.colors = [firstColor, secondColor].map {$0.cgColor}
//            layer?.locations = [0.60, 0.75, 1]
//        } else {
//            layer?.colors = [firstColor, secondColor, thirdColor].map {$0.cgColor}
//            layer?.locations = [0.0, 0.70, 1]
//        }
//        if (isHorizontal) {
//            if Localizer.current == .arabic {
//                layer?.startPoint = CGPoint(x: 1, y: 0.5)
//                layer?.endPoint = CGPoint (x: 0, y: 0.5)
//            } else {
//                layer?.startPoint = CGPoint(x: 0, y: 0.5)
//                layer?.endPoint = CGPoint (x: 1, y: 0.5)
//            }
//        } else {
//            layer?.startPoint = CGPoint(x: 0.5, y: 0)
//            layer?.endPoint = CGPoint (x: 0.5, y: 1)
//        }
    }
    func updateView(frame: CGRect) {
        let layer = self.layer as? CAGradientLayer
        layer?.frame = frame
    }
}

@IBDesignable
class GradientButton: UIButton {
    
    @IBInspectable var firstColor: UIColor = R.color.mainColor() ?? .clear  {
        didSet {
            updateBtn()
        }
    }
    
    @IBInspectable var secondColor: UIColor = R.color.secondColor() ?? .clear {
        didSet {
            updateBtn()
        }
    }
    var thirdColor: UIColor = .clear {
        didSet {
            updateBtn()
        }
    }
    @IBInspectable var isHorizontal: Bool = true {
        didSet {
            updateBtn()
        }
    }
    
    override class var layerClass: AnyClass {
        get {
            return CAGradientLayer.self
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    func setupButton() {
        setTitleColor(.white, for: .normal)
        titleLabel?.font     = ThemeApp.Fonts.regularFont(size: 18)
        self.shadowColor = R.color.shadowColorRed() ?? .clear
        self.shadowOffset = CGSize(width: 0, height: 6)
        self.shadowRadius = 12
        self.shadowOpacity = 0.8
        layer.cornerRadius   = 15
        self.updateBtn()
    }
    
    func updateBtn() {
        self.applyGradient()
//        let layer = self.layer as? CAGradientLayer
//        if thirdColor == .clear {
//            layer?.colors = [firstColor, secondColor].map {$0.cgColor}
//            layer?.locations = [0.60, 0.75, 1]
//        } else {
//            layer?.colors = [firstColor, secondColor, thirdColor].map {$0.cgColor}
//            layer?.locations = [0.0, 0.70, 1]
//        }
//        if (isHorizontal) {
//            if Localizer.current == .arabic {
//                layer?.startPoint = CGPoint(x: 1, y: 0.5)
//                layer?.endPoint = CGPoint (x: 0, y: 0.5)
//            } else {
//                layer?.startPoint = CGPoint(x: 0, y: 0.5)
//                layer?.endPoint = CGPoint (x: 1, y: 0.5)
//            }
//        } else {
//            layer?.startPoint = CGPoint(x: 0.5, y: 0)
//            layer?.endPoint = CGPoint (x: 0.5, y: 1)
//        }
    }
    func updateView(frame: CGRect) {
        let layer = self.layer as? CAGradientLayer
        layer?.frame = frame
    }
}
//
//var gradientFirstColors: [UIButton: UIColor] = [:]
//var gradientSecondColors: [UIButton: UIColor] = [:]
//extension UIButton {
//    @IBInspectable public var firstGredColor: UIColor {
//        set {
//            gradientFirstColors[self] = newValue
//            updateView()
//        } get {
//            return gradientFirstColors[self] ?? .clear
//        }
//    }
//    
//    @IBInspectable public var secondGredColor: UIColor {
//        set {
//            gradientSecondColors[self] = newValue
//            updateView()
//        } get {
//            return gradientSecondColors[self] ?? .clear
//        }
//    }
//    
//    open override class var layerClass: AnyClass {
//        get {
//            return CAGradientLayer.self
//        }
//    }
//    func updateView() {
//        let layer = self.layer as? CAGradientLayer
//        layer?.colors = [firstGredColor, secondGredColor].map {$0.cgColor}
//        layer?.locations = [0.0, 0.70, 1]
//        if Localizer.current == .arabic {
//            layer?.startPoint = CGPoint(x: 1, y: 0.5)
//            layer?.endPoint = CGPoint (x: 0, y: 0.5)
//        } else {
//            layer?.startPoint = CGPoint(x: 0, y: 0.5)
//            layer?.endPoint = CGPoint (x: 1, y: 0.5)
//        }
//    }
//}
