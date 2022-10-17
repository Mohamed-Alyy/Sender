//
//  CategoryStoresModel.swift
//  Mutsawiq
//
//  Created by M.abdu on 11/8/20.
//  Copyright © 2020 com.Rowaad. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class QuantityView: UIView {
   
   
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var quantityLbl: UILabel!
    
    var item: QuantityModel?
    weak var dataSource: QuantityViewDataSource? {
        didSet {
            item = dataSource?.quantityView(self)
            if item?.quantity == nil {
                item?.quantity = 0
            }
            updateView()
        }
    }
    weak var delegate: QuantityViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initNib()
        updateView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initNib()
        updateView()
    }
    
    func initNib() {
        let bundle = Bundle(for: QuantityView.self)
        bundle.loadNibNamed("QuantityView", owner: self, options: nil)
        addSubview(container)
        container.frame = bounds
        container.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|", options: [], metrics: nil, views: ["childView": container ?? UIView()]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|", options: [], metrics: nil, views: ["childView": container ?? UIView()]))
    }
    @IBAction func plus(_ sender: Any) {
        guard item?.stock != item?.quantity else {return}
        item?.quantity? += 1
        delegate?.quantityView(self, didChange: item)
        updateView()
    }
    @IBAction func minus(_ sender: Any) {
        if item?.quantity ?? 0 <= 0 {
            return
        }
        item?.quantity? -= 1
        delegate?.quantityView(self, didChange: item)
        updateView()
    }
}

extension QuantityView {
    func updateView() {
        quantityLbl.text = item?.quantity?.string
    }
    func plus() {
        plus(self)
    }
    func minus() {
        minus(self)
    }
}
