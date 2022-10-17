//
//  MealFilterVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/24/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class MealFilterVC: BaseController {
    
    @IBOutlet weak var foodSectionBtn: UIButton!
    @IBOutlet weak var sortByBtn: UIButton!
    @IBOutlet weak var priceSlider: RangeSeekSlider!
    var presenter: MealFilterPresenter?
    var router: MealFilterRouter?
    weak var delegate: MealFilterDelegate?
    var provider: Provider?
    var subCategory: Provider.SubCategory?
    var sort: Sort?
    var minPrice: CGFloat?
    var maxPrice: CGFloat?
}

// MARK: - ...  LifeCycle
extension MealFilterVC {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter = .init()
        presenter?.view = self
        router = .init()
        router?.view = self
        setup()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter = nil
        router = nil
    }
}
// MARK: - ...  Functions
extension MealFilterVC {
    func setup() {
        priceSlider.maxValue = provider?.maxPrice?.cgFloat ?? 0
        priceSlider.selectedMaxValue = provider?.maxPrice?.cgFloat ?? 0
        priceSlider.minValue = 0
        priceSlider.selectedMinValue = 0
        priceSlider.minLabel.string = "0 \("SAR".localized)"
        priceSlider.maxLabel.string = "\(priceSlider.maxValue) \("SAR".localized)"
        priceSlider.delegate = self
    }
    override func backBtn(_ sender: Any) {
        router?.didFilter()
    }
    @IBAction func foodSection(_ sender: Any) {
        guard let scene = R.storyboard.pickerViewHelper.pickerController() else { return }
        scene.source = provider?.subcategories ?? []
        scene.titleClosure = { [weak self] row in
            return self?.provider?.subcategories?[row].name
        }
        scene.didSelectClosure = { [weak self] row in
            let item = self?.provider?.subcategories?[row]
            self?.foodSectionBtn.setTitle(item?.name, for: .normal)
            self?.subCategory = item
        }
        pushPop(scene)
    }
    @IBAction func sortBy(_ sender: Any) {
        guard let scene = R.storyboard.pickerViewHelper.pickerController() else { return }
        scene.source = [Sort.asc, Sort.desc]
        scene.titleClosure = { row in
            if row == 0 {
                return Sort.asc.rawValue.localized
            } else {
                return Sort.desc.rawValue.localized
            }
        }
        scene.didSelectClosure = { [weak self] row in
            if row == 0 {
                self?.sortByBtn.setTitle(Sort.asc.rawValue.localized, for: .normal)
                self?.sort = Sort.asc
            } else {
                self?.sortByBtn.setTitle(Sort.desc.rawValue.localized, for: .normal)
                self?.sort = Sort.desc
            }
        }
        pushPop(scene)
    }
    @IBAction func apply(_ sender: Any) {
        router?.didFilter()
    }
}
// MARK: - ...  View Contract
extension MealFilterVC: MealFilterViewContract {
}

extension MealFilterVC: RangeSeekSliderDelegate {
    func rangeSeekSlider(_ slider: RangeSeekSlider, didChange minValue: CGFloat, maxValue: CGFloat) {
        self.minPrice = minValue
        self.maxPrice = maxValue
    }
}
