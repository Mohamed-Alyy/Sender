//
//  ReservationTableVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/25/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class ReservationTableVC: BaseController {
    @IBOutlet weak var dateTxf: UITextField!
    @IBOutlet weak var hourTxf: UITextField!
    @IBOutlet weak var minuteTxf: UITextField!
    @IBOutlet weak var personsNumBtn: UIButton!
    @IBOutlet weak var servicesCollection: TagCollectionView!
    var presenter: ReservationTablePresenter?
    var router: ReservationTableRouter?
    weak var delegate: ReservationTableDelegate?
    var provider: Provider?
    var filterOptions: FilterOptionModel.DataClass?
    var bookModel: ReservationTableModel?
}

// MARK: - ...  LifeCycle
extension ReservationTableVC {
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
extension ReservationTableVC {
    func setup() {
        startLoading()
        presenter?.fetchFilter()
        if bookModel == nil {
            bookModel = .init()
            bookModel?.providerID = provider?.id
            bookModel?.services = []
        }
        servicesCollection.delegate = self
        servicesCollection.dataSource = self
    }
    func setupOldBook() {
        let date = DateHelper().date(date: bookModel?.date, format: "dd/MM/yyyy", oldFormat: "yyyy-MM-dd")
        self.dateTxf.text = date
        let hour = DateHelper().date(date: bookModel?.hour, format: "h a", oldFormat: "HH:mm:ss")
        self.hourTxf.text = hour
        let minute = DateHelper().date(date: bookModel?.hour, format: "mm", oldFormat: "HH:mm:ss")
        self.minuteTxf.text = minute
        self.personsNumBtn.setTitle(bookModel?.persons?.string, for: .normal)
        
        DateHelper.currentLocal = .english
        self.bookModel?.date = DateHelper().date(date: bookModel?.date, format: "MM/dd/yyyy", oldFormat: "yyyy-MM-dd")
        self.bookModel?.hour = DateHelper().date(date: bookModel?.hour, format: "h:mm a", oldFormat: "HH:mm:ss")
        DateHelper.currentLocal = nil
        
        for service in bookModel?.services ?? [] {
            for index in 0..<(filterOptions?.features?.count ?? 0) {
                if filterOptions?.features?[index].id == service.id {
                    servicesCollection.selectedItemsPaths.append(index)
                    break
                }
            }
        }
        servicesCollection.selectedItemsTags = bookModel?.services ?? []
        servicesCollection.reload()
        tagCollectionView(for: servicesCollection, at: 0)
    }
}
extension ReservationTableVC {
    @IBAction func date(_ sender: Any) {
        guard let scene = R.storyboard.pickTimeController.pickTimeController() else { return }
        scene.type = .date
        scene.closureTime = { [weak self] date in
            DateHelper.currentLocal = .english
            let time = DateHelper().date(date: date, format: "dd/MM/yyyy")
            self?.bookModel?.month = DateHelper().date(date: date, format: "MMMM")
            self?.bookModel?.day = DateHelper().date(date: date, format: "dd")
            self?.dateTxf.text = time
            self?.bookModel?.date = DateHelper().date(date: date, format: "MM/dd/yyyy")
            DateHelper.currentLocal = nil
        }
        pushPop(scene)
    }
    @IBAction func hours(_ sender: Any) {
        if !validate(txfs: [dateTxf]) {
            return
        }
        guard let scene = R.storyboard.pickTimeController.pickTimeController() else { return }
        scene.type = .time
       
        
        //check if reservation today or not
        let currentDate = DateHelper().currentDate()
        let reserveDate = DateHelper().date(date: self.bookModel?.date, format: "yyyy-MM-dd", oldFormat: "MM/dd/yyyy")
        if currentDate == reserveDate {
            //let fromTimeProvider = "\(provider?.attributes?.from ?? ""):00"
            let toTimeProvider = "\(provider?.attributes?.to ?? ""):00"
            let currentTime = DateHelper().date(date: Date(), format: "HH:mm:ss")
            //let toHour = DateHelper().originalDate(original: toTimeProvider, oldFormat: "HH:mm:ss")
            let currentSeconds = DateHelper().secondsForDate(firstDate: currentTime, oldFormat: "HH:mm:ss") ?? 0
            let toSeconds = DateHelper().secondsForDate(firstDate: toTimeProvider, oldFormat: "HH:mm:ss") ?? 0
            scene.minDate = Date()
            scene.maxDate = Date().addingTimeInterval((toSeconds - currentSeconds).double)
            scene.useMaxDate = true
        } else {
            let fromHour = DateHelper().originalDate(original: provider?.attributes?.from ?? "", oldFormat: "h:mm a")
            let currentSeconds = DateHelper().secondsForDate(firstDate: provider?.attributes?.from ?? "", oldFormat: "h:mm a") ?? 0
            let toSeconds = DateHelper().secondsForDate(firstDate: provider?.attributes?.to ?? "", oldFormat: "h:mm a") ?? 0
            scene.minDate = fromHour
            scene.maxDate = Date().addingTimeInterval((toSeconds - currentSeconds).double)
            scene.useMaxDate = true
        }
        //
        scene.closureTime = { [weak self] date in
            DateHelper.currentLocal = .english
            let hour = DateHelper().date(date: date, format: "h a")
            self?.hourTxf.text = hour
            self?.bookModel?.hourText = DateHelper().date(date: date, format: "h:mm a")
            self?.bookModel?.hour = DateHelper().date(date: date, format: "h:mm a")
            DateHelper.currentLocal = nil
            
            DateHelper.currentLocal = .english
            let minute = DateHelper().date(date: date, format: "mm")
            self?.minuteTxf.text = minute
            self?.bookModel?.minute = DateHelper().date(date: date, format: "mm")
            DateHelper.currentLocal = nil
        }
        pushPop(scene)
    }
    @IBAction func minutes(_ sender: Any) {
        hours(sender)
    }
    @IBAction func persons(_ sender: Any) {
        guard let scene = R.storyboard.pickerViewHelper.pickerController() else { return }
        scene.source = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
        scene.titleClosure = { row in
            return (row+1).string
        }
        scene.didSelectClosure = { [weak self] row in
            let item = (row+1)
            self?.personsNumBtn.setTitle(item.string, for: .normal)
            self?.bookModel?.persons = item
        }
        pushPop(scene)
    }
   
    @IBAction func book(_ sender: Any) {
        if !validate(txfs: [dateTxf, hourTxf, minuteTxf]) {
            return
        }
        if servicesCollection.selectedItemsTags.count == 0 {
            return openConfirmation(title: "Please select at least 1 feature".localized)
        }
        if bookModel?.persons == nil || bookModel?.persons == 0 {
            return openConfirmation(title: "Please select at least 1 person".localized)
        }
        startLoading()
        let services = servicesCollection?.selectedItemsTags as? [FilterOptionModel.Feature]
        bookModel?.services?.removeAll()
        bookModel?.services?.append(contentsOf: services ?? [])
        presenter?.book(bookModel: bookModel)
    }
    override func backBtn(_ sender: Any) {
        router?.didBooked()
    }
}
// MARK: - ...  View Contract
extension ReservationTableVC: ReservationTableViewContract, PopupConfirmationViewContract {
    func didFetchFilter(for model: FilterOptionModel.DataClass?) {
        stopLoading()
        filterOptions = model
        if bookModel?.reservationID != nil {
            setupOldBook()
        }
    }
    func didBooked() {
        stopLoading()
        router?.didBooked(booked: true)
    }
}

extension ReservationTableVC: TagCollectionViewDelegate, TagCollectionViewDataSource {
    func tagCollectionView(for collection: TagCollectionView?) -> [TagModel] {
        return filterOptions?.features ?? []
    }
    func tagCollectionView(for TagCollectionView: TagCollectionView?, at didSelectItem: Int) {

    }
}
