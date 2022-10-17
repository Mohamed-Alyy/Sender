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
class EditTextFieldView: UIView {
   
    @IBInspectable public var titleView: String {
        get {
            return self.titleView
        }
        set {
            self.placeHolderLbl.text = newValue.localized
            self.textTxf.localizationPlaceHolder = newValue.localized
        }
    }
    public var text: String? {
        get {
            return self.textTxf.text
        }
        set {
            self.textTxf.text = newValue
        }
    }
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var placeHolderLbl: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var textTxf: UITextField!
    
    var editable: Bool = false
    weak var delegate: EditViewDelegate?
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
        let bundle = Bundle(for: EditTextFieldView.self)
        bundle.loadNibNamed("EditTextFieldView", owner: self, options: nil)
        addSubview(container)
        container.frame = bounds
        container.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|", options: [], metrics: nil, views: ["childView": container ?? UIView()]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|", options: [], metrics: nil, views: ["childView": container ?? UIView()]))
    }

    @IBAction func edit(_ sender: Any) {
        editable = !editable
        if !editable {
            delegate?.editView(didSave: self)
        } else {
            delegate?.editView(didEdit: self)
        }
        updateView()
    }
}
extension EditTextFieldView {
    func updateView() {
        if editable {
            editBtn.setTitle("SAVE".localized, for: .normal)
            textTxf.isUserInteractionEnabled = true
            textTxf.becomeFirstResponder()
        } else {
            editBtn.setTitle("EDIT".localized, for: .normal)
            textTxf.isUserInteractionEnabled = false
            textTxf.endEditing(true)
        }
    }
    func reload() {
       
    }
}
