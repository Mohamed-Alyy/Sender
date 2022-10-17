//
//  CategoryFilterVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/20/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class CategoryFilterVC: BaseController {
    @IBOutlet weak var resturantTypeBtn: UIButton!
    @IBOutlet weak var foodTypeBtn: UIButton!
    var presenter: CategoryFilterPresenter?
    var router: CategoryFilterRouter?
    var options: FilterOptionModel.DataClass?
    var resturantType: Int?
    var foodType: Int?
    var delegate: CategoryFilterDelegate?
}

// MARK: - ...  LifeCycle
extension CategoryFilterVC {
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
extension CategoryFilterVC {
    func setup() {
        startLoading()
        presenter?.fetchFilter()
    }
}
extension CategoryFilterVC {
    @IBAction func resturantType(_ sender: Any) {
        guard let scene = R.storyboard.pickerViewHelper.pickerController() else { return }
        scene.source = options?.nationality ?? []
        scene.titleClosure = { [weak self] row in
            return self?.options?.nationality?[row].name
        }
        scene.didSelectClosure = { [weak self] row in
            let item = self?.options?.nationality?[row]
            self?.resturantTypeBtn.setTitle(item?.name, for: .normal)
            self?.resturantType = item?.id
        }
        pushPop(scene)
    }
    @IBAction func foodType(_ sender: Any) {
        guard let scene = R.storyboard.pickerViewHelper.pickerController() else { return }
        scene.source = options?.subcategories ?? []
        scene.titleClosure = { [weak self] row in
            return self?.options?.subcategories?[row].name
        }
        scene.didSelectClosure = { [weak self] row in
            let item = self?.options?.subcategories?[row]
            self?.foodTypeBtn.setTitle(item?.name, for: .normal)
            self?.resturantType = item?.id
        }
        pushPop(scene)
    }
    override func backBtn(_ sender: Any) {
        router?.didFilter()
    }
    @IBAction func apply(_ sender: Any) {
        if foodType == nil && resturantType == nil {
            openConfirmation(title: "Please select at leaset filter option".localized)
            return
        }
        var paramters: [String: Any] = [:]
        paramters["resturant"] = resturantType
        paramters["food"] = foodType
        router?.didFilter(paramters: paramters)
    }
}
// MARK: - ...  View Contract
extension CategoryFilterVC: CategoryFilterViewContract, PopupConfirmationViewContract {
    func didFetchFilter(for model: FilterOptionModel.DataClass?) {
        stopLoading()
        options = model
    }
}
