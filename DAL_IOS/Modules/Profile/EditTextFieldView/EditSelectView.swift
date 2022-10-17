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
class EditSelectView: UIView {
   
    @IBInspectable public var titleView: String {
        get {
            return self.titleView
        }
        set {
            self.placeHolderLbl.text = newValue.localized
        }
    }
    public var text: String? {
        get {
            return self.selectedLbl.text
        }
        set {
            self.selectedLbl.text = newValue
        }
    }
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var placeHolderLbl: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var selectedLbl: UILabel!
    
    var editable: Bool = false
    var selectedItem: Int = 0
    weak var delegate: EditViewDelegate?
    var source: [Int] = [0, 1]
    var sourceString: [String] = ["MALE", "FEMALE"]
    var view: BaseController? {
        get {
            let view = delegate as? BaseController
            return view
        }
    }
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
        let bundle = Bundle(for: EditSelectView.self)
        bundle.loadNibNamed("EditSelectView", owner: self, options: nil)
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
        }
        updateView()
    }
    @IBAction func openList(_ sender: Any) {
        if !editable {
            return
        }
        didOpenTags()
    }
}

extension EditSelectView {
    func updateView() {
        if editable {
            placeHolderLbl.UIViewAction { [weak self] in
                self?.didOpenTags()
            }
            selectedLbl.UIViewAction { [weak self] in
                self?.didOpenTags()
            }
            editBtn.setTitle("SAVE".localized, for: .normal)
        } else {
            placeHolderLbl.UIViewAction {
            
            }
            selectedLbl.UIViewAction {
                
            }
            editBtn.setTitle("EDIT".localized, for: .normal)
        }
    }
    func reload() {
    }
    func didOpenTags() {
        guard let scene = R.storyboard.pickerViewHelper.pickerController() else { return }
        scene.source = source
        scene.titleClosure = { [unowned self] row in
            if self.source.count == 2 {
                return self.sourceString[row].localized
            } else {
                return self.source[row].string
            }
        }
        scene.didSelectClosure = { row in
            if self.source.count == 2 {
                self.selectedLbl.text = self.sourceString[row].localized
            } else {
                self.selectedLbl.text = self.source[row].string
            }
            self.selectedItem = self.source[row]
        }
        self.view?.pushPop(scene)
    }
}
