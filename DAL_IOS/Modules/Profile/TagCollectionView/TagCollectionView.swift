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
class TagCollectionView: UIView {
   
    @IBInspectable public var titleCollection: String {
        get {
            return self.titleCollection
        }
        set {
            self.placeHolderLbl.text = newValue.localized
        }
    }
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var TagCollection: UICollectionView!
    @IBOutlet weak var placeHolderLbl: UILabel!
    
    var onlyItemSelected: Bool = false
    var selectedItemsPaths: [Int] = []
    var selectedItemsTags: [TagModel] = []
    weak var delegate: TagCollectionViewDelegate?
    weak var dataSource: TagCollectionViewDataSource? {
        didSet {
            self.reload()
        }
    }
    var source: [TagModel] {
        return dataSource?.tagCollectionView(for: self) ?? []
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
        let bundle = Bundle(for: TagCollectionView.self)
        bundle.loadNibNamed("TagCollectionView", owner: self, options: nil)
        addSubview(container)
        container.frame = bounds
        container.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|", options: [], metrics: nil, views: ["childView": container ?? UIView()]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|", options: [], metrics: nil, views: ["childView": container ?? UIView()]))
    }
    @IBAction func didOpenTags(_ sender: Any) {
        if selectedItemsTags.count == source.count {
            return
        }
        guard let scene = R.storyboard.pickerViewHelper.pickerController() else { return }
        scene.source = source
        scene.titleClosure = { [unowned self] row in
            return self.source[row].name
        }
        scene.didSelectClosure = { row in
            if self.onlyItemSelected {
                self.selectedItemsTags.removeAll()
                self.selectedItemsPaths.removeAll()
            }
            let item = self.source[row]
            if !self.selectedItemsPaths.contains(row) {
                self.selectedItemsPaths.append(row)
                self.selectedItemsTags.append(item)
                self.delegate?.tagCollectionView(for: self, at: row)
                self.reload()
            }
        }
        self.view?.pushPop(scene)
    }
}

extension TagCollectionView {
    func updateView() {
        TagCollection.delegate = self
        TagCollection.dataSource = self
        placeHolderLbl.UIViewAction { [weak self] in
            self?.didOpenTags("")
        }
    }
    func reload() {
        if selectedItemsTags.count > 0 {
            placeHolderLbl.isHidden = true
        } else {
            placeHolderLbl.isHidden = false
        }
        TagCollection.reloadData()
        reloadHeights()
    }
    func reloadHeights() {
        if let constraint = container.constraints.first(where: { $0.firstAttribute == .height }) {
            if selectedItemsTags.count < 3 {
                constraint.constant = 54
            } else if selectedItemsTags.count >= 3 {
                constraint.constant = TagCollection.collectionViewLayout.collectionViewContentSize.height
            }
        }
        view?.updateViewConstraints()
        view?.loadViewIfNeeded()
    }
}

extension TagCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = selectedItemsTags[indexPath.row].name
        var textWidth = (text?.widthWithConstrainedWidth(width: collectionView.width, font: ThemeApp.Fonts.regularFont(size: 18)) ?? 40)
        if textWidth < 40 {
            textWidth = 60
        }
        let width = 40 + textWidth
        return CGSize(width: width, height: 40)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedItemsTags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cell(type: TagCollectionCell.self, indexPath)
        cell.tagNameLbl.text = selectedItemsTags[indexPath.row].name
        cell.delegate = self
        return cell
    }
}
extension TagCollectionView: TagCollectionCellDelegate {
    func removeTag(path: Int) {
        self.selectedItemsPaths.remove(at: path)
        self.selectedItemsTags.remove(at: path)
        self.reload()
    }
}
