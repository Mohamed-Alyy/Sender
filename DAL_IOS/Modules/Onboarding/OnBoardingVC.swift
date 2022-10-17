//
//  OnBoardingVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 12/28/20.
//  Copyright © 2020 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class OnBoardingVC: BaseController {
    @IBOutlet weak var boardingCollection: UICollectionView!
    var presenter: OnBoardingPresenter?
    var router: OnBoardingRouter?
}

// MARK: - ...  LifeCycle
extension OnBoardingVC {
    override func viewDidLoad() {
        super.hideNav = true
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
extension OnBoardingVC {
    func setup() {
        boardingCollection.dataSource = self
        boardingCollection.delegate = self
        boardingCollection.reloadData()
        boardingCollection.infiniteScrolling = false
        boardingCollection.autoScrolling()
    }
}
// MARK: - ...  View Contract
extension OnBoardingVC: OnBoardingViewContract {
}

extension OnBoardingVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width, height: collectionView.height)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let cell = cell as? OnBoardingCell {
            cell.pageControl.currentPage = indexPath.row
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cell(type: OnBoardingCell.self, indexPath)
        cell.delegate = self
        cell.setup()
        return cell
    }
}

extension OnBoardingVC: OnBoardingCellDelegate {
    func onBoardingCell(_ cell: OnBoardingCell, next for: Bool) {
        let path = IndexPath(row: (cell.path ?? 0) + 1, section: 0)
        self.boardingCollection.scrollToItem(at: path, at: .centeredHorizontally, animated: true)
    }
    func onBoardingCell(_ cell: OnBoardingCell, start for: Bool) {
        self.router?.startApplication()
    }
}
