//
//  ReservationsFilterVC.swift
//  DAL_IOS
//
//  Created by Mabdu on 16/02/2021.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit
// MARK: - ...  ViewController - Vars
class ReservationsFilterVC: BaseController {
    @IBOutlet weak var fromTxf: UITextField!
    @IBOutlet weak var toTxf: UITextField!
    @IBOutlet weak var statusBtn: UIButton!
    @IBOutlet weak var morningBtn: RadioButton!
    @IBOutlet weak var nightBtn: RadioButton!
    var presenter: ReservationsFilterPresenter?
    var router: ReservationsFilterRouter?
    weak var delegate: ReservationFilterDelegate?
    var filter: ReservationsFilterModel?
}

// MARK: - ...  LifeCycle
extension ReservationsFilterVC {
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
        setupRadioBtns()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter = nil
        router = nil
    }
}
// MARK: - ...  Functions
extension ReservationsFilterVC {
    func setup() {
        filter = .init()
    }
    func setupRadioBtns() {
        morningBtn.onSelect { [weak self] in
            self?.nightBtn.deselect()
            self?.filter?.time = .am
        }
        morningBtn.onDeselect { [weak self] in
            if self?.filter?.time == .am {
                self?.filter?.time = nil
            }
        }
        nightBtn.onSelect { [weak self] in
            self?.morningBtn.deselect()
            self?.filter?.time = .pm
        }
        nightBtn.onDeselect { [weak self] in
            if self?.filter?.time == .pm {
                self?.filter?.time = nil
            }
        }
    }
}
extension ReservationsFilterVC {
    override func backBtn(_ sender: Any) {
        router?.didApply(for: false)
    }
    @IBAction func fromPreiod(_ sender: Any) {
        guard let scene = R.storyboard.pickTimeController.pickTimeController() else { return }
        scene.type = .date
        scene.setMiniDate = false
        scene.closureTime = { [weak self] date in
            let time = DateHelper().date(date: date, format: "yyyy-MM-dd")
            self?.fromTxf.text = time
            DateHelper.currentLocal = .english
            self?.filter?.from = DateHelper().date(date: date, format: "yyyy-MM-dd")
            DateHelper.currentLocal = nil
        }
        pushPop(scene)
    }
    @IBAction func toPreiod(_ sender: Any) {
        guard let scene = R.storyboard.pickTimeController.pickTimeController() else { return }
        scene.type = .date
        scene.setMiniDate = false
        scene.closureTime = { [weak self] date in
            let time = DateHelper().date(date: date, format: "yyyy-MM-dd")
            self?.toTxf.text = time
            DateHelper.currentLocal = .english
            self?.filter?.to = DateHelper().date(date: date, format: "yyyy-MM-dd")
            DateHelper.currentLocal = nil
        }
        pushPop(scene)
    }
    @IBAction func status(_ sender: Any) {
        let status = ["new", "processing", "completed", "cancelled"]
        guard let scene = R.storyboard.pickerViewHelper.pickerController() else { return }
        scene.source = ["new", "processing", "completed", "cancelled"]
        scene.titleClosure = { row in
            return status[row].localized
        }
        scene.didSelectClosure = { [weak self] row in
            self?.statusBtn.setTitle(status[row], for: .normal)
            self?.filter?.status = status[row]
        }
        pushPop(scene)
    }
    @IBAction func apply(_ sender: Any) {
        router?.didApply(for: true)
    }
}
// MARK: - ...  View Contract
extension ReservationsFilterVC: ReservationsFilterViewContract {
}
