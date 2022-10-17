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
class FilterView: UIView {
   
    @IBInspectable public var titleCollection: String {
        get {
            return self.titleCollection
        }
        set {
            self.placeHolderLbl.text = newValue.localized
        }
    }
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var filtersTbl: UITableView!
    @IBOutlet weak var placeHolderLbl: UILabel!
    @IBOutlet weak var showMoreBtn: UIButton!
    @IBOutlet weak var showMoreImage: UIImageView!
    
    
    var onlyItemSelected: Bool = false
    var isShowMore: Bool = false
    var selectedItemsPaths: [Int] = []
    var selectedItemsTags: [FilterModel] = []
    weak var delegate: FilterViewDelegate?
    weak var dataSource: FilterViewDataSource? {
        didSet {
            self.reload()
        }
    }
    var source: [FilterModel] {
        return dataSource?.filterView(for: self) ?? []
    }
    var view: BaseController? {
        get {
            let view = dataSource as? BaseController
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
        let bundle = Bundle(for: FilterView.self)
        bundle.loadNibNamed("FilterView", owner: self, options: nil)
        addSubview(container)
        container.frame = bounds
        container.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|", options: [], metrics: nil, views: ["childView": container ?? UIView()]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|", options: [], metrics: nil, views: ["childView": container ?? UIView()]))
        showMoreBtn.setTitle("Show more".localized, for: .normal)
    }
    @IBAction func showMore(_ sender: Any) {
        isShowMore = !isShowMore
        let title = isShowMore ? "Show less".localized : "Show more".localized
        showMoreBtn.setTitle(title, for: .normal) 
        reload()
    }
}
extension FilterView {
    func updateView() {
        filtersTbl.delegate = self
        filtersTbl.dataSource = self
        updateHeight()
        hide()
    }
    func hide() {
        if source.count > 3 {
            showMoreBtn.isHidden = false
            showMoreImage.isHidden = false
//            if let constraint = showMoreBtn.constraints.first(where: { $0.firstAttribute == .height }) {
//                constraint.constant = 34
//            }
        } else {
            showMoreBtn.isHidden = true
            showMoreImage.isHidden = true
//            if let constraint = showMoreBtn.constraints.first(where: { $0.firstAttribute == .height }) {
//                constraint.constant = -15
//            }
        }
    }
    func reload() {
        filtersTbl.reloadData()
        updateHeight()
        hide()
    }
    func updateHeight() {
        if let constraint = filtersTbl.constraints.first(where: { $0.firstAttribute == .height }) {
            if self.isShowMore {
                constraint.constant = source.count.cgFloat * 45
            } else {
                if source.count > 3 {
                    constraint.constant = 45 * 3
                } else {
                    constraint.constant = 45 * source.count.cgFloat
                }
            }
        }
    }
}

extension FilterView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isShowMore {
            return source.count
        } else {
            if source.count > 3 {
                return 3
            } else {
                return source.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.cell(type: FilterTableCell.self, indexPath)
        var model: FilterModel?
        if selectedItemsPaths.contains(indexPath.row) {
            model = source[indexPath.row]
            model?.checked = true
        } else {
            model = source[indexPath.row]
            model?.checked = false
        }
        cell.model = model
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //updateHeight()
    }
}

extension FilterView: FilterTableCellDelegate {
    func filterTableCell(didSelect cell: FilterTableCell) {
        if selectedItemsPaths.contains(cell.indexPath()) {
            return
        }
        if onlyItemSelected {
            selectedItemsTags.removeAll()
            selectedItemsPaths.removeAll()
        }
        delegate?.filterView(for: self, at: cell.indexPath())
        selectedItemsPaths.append(cell.indexPath())
        selectedItemsTags.append(source[cell.indexPath()])
        reload()
    }
    
    func filterTableCell(didDeselect cell: FilterTableCell) {
        if selectedItemsPaths.contains(cell.indexPath()) {
            selectedItemsPaths.remove(at: cell.indexPath())
            selectedItemsTags.remove(at: cell.indexPath())
            reload()
        }
    }
}
