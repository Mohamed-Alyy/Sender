//
//  CustomTabBarView.swift
//  Massaser
//
//  Created by M.abdu on 8/31/20.
//  Copyright © 2020 MohamedAbdu. All rights reserved.
//

import Foundation
import UIKit

class NibsView: UIView {
    var viewHeight: CGFloat = 200
    weak var scene: UIViewController?

    func setNibInsideView(view: UIViewController?) {
        guard let view = view else { return }
        self.scene = view
        //self = NibsView(frame: CGRect(x: 0, y: 0, width: view.view.width-50, height: self.height))
        self.translatesAutoresizingMaskIntoConstraints = false
        self.clipsToBounds = true
        view.view.addSubview(self)
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: view.view.leadingAnchor, constant: 25),
            self.trailingAnchor.constraint(equalTo: view.view.trailingAnchor, constant: -25),
            self.heightAnchor.constraint(greaterThanOrEqualToConstant: viewHeight), // Fixed height for nav menu
            self.centerYAnchor.constraint(equalTo: view.view.centerYAnchor)
        ])
        view.view.layoutIfNeeded() // important step
    }
}
class PopupConfirmationView: NibsView {
    typealias OnClickAgree = (() -> Void)
    typealias OnClickSkip = (() -> Void)
    enum ModalBtns {
        case agree
        case skip
        
    }
    
    @IBOutlet weak var containerView: GradientView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var stackBtns: UIStackView!
//    @IBOutlet weak var stackHeight: NSLayoutConstraint!
    @IBOutlet weak var agreeBtn: UIButton!
    @IBOutlet weak var skipBtn: UIButton!
    
    var view: UIView!
    var onClickAgree: OnClickAgree?
    var onClickSkip: OnClickSkip?
    var text: String?
    var btns: [ModalBtns] = []

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }
    init(frame: CGRect, text: String?, btns: [ModalBtns]) {
        super.init(frame: frame)
        self.xibSetup()
        self.text = text
        self.btns = btns
        self.setupView()
    }
    func setupView() {
        titleLbl.text = text
        agreeBtn.UIViewAction { [weak self] in
            self?.scene?.dismiss(animated: false, completion: {
                self?.onClickAgree?()
            })
        }
        skipBtn.UIViewAction { [weak self] in
            self?.scene?.dismiss(animated: false, completion: {
                self?.onClickSkip?()
            })
        }
        if btns.count > 1 {
            return
        }
        if btns.contains(.agree) {
            skipBtn.isHidden = true
//            stackHeight.constant = 50
        } else {
            agreeBtn.isHidden = true
//            stackHeight.constant = 50
        }
        
    }
    func xibSetup() {
        view = loadNib()
        self.view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        view.frame = bounds
        addSubview(view)
        // add Constraints
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|", options: [], metrics: nil, views: ["childView": view]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|", options: [], metrics: nil, views: ["childView": view]))
        self.viewHeight = self.containerView.height
        
    }
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView ?? UIView()
    }
}
