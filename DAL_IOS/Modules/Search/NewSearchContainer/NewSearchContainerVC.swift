//
//  NewSearchContainerVC.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/18/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ...  ViewController - Vars
class NewSearchContainerVC: BaseController {
    @IBOutlet weak var searchTbl: UITableView!
    @IBOutlet weak var showMoreBtn: UIButton!
    @IBOutlet weak var tagsCollection: UICollectionView!
    var presenter: NewSearchContainerPresenter?
    var router: NewSearchContainerRouter?
    var tags: [String] = []
    var isShowMore: Bool = false
    var history: [String] {
        return SearchHistory().fetch()
    }
}

// MARK: - ...  LifeCycle
extension NewSearchContainerVC {
    override func viewDidLoad() {
        super.hideNav = true
        super.viewDidLoad()
        presenter = .init()
        presenter?.view = self
        router = .init()
        router?.view = self
        setup()
        setupHistory()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}
// MARK: - ...  Functions
extension NewSearchContainerVC {
    func setup() {
        tagsCollection.delegate = self
        tagsCollection.dataSource = self
        searchTbl.delegate = self
        searchTbl.dataSource = self
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("NEW_SEARCH"), object: nil)
        
    }
    func setupHistory() {
        searchTbl.reloadData()
        if history.count < 3 {
            showMoreBtn.isHidden = true
        } else {
            showMoreBtn.isHidden = false
        }
        reloadHeight()
    }
    func reloadHeight() {
        if let constraint = tagsCollection.constraints.first(where: { $0.firstAttribute == .height }) {
            constraint.constant = tagsCollection.collectionViewLayout.collectionViewContentSize.height
        }
        if let constraint = searchTbl.constraints.first(where: { $0.firstAttribute == .height }) {
            if self.isShowMore {
                constraint.constant = 60 * history.count.cgFloat
            } else {
                if history.count > 3 {
                    constraint.constant = 60 * 3
                } else {
                    constraint.constant = 60 * history.count.cgFloat
                }
            }
        }
    }
    @objc func methodOfReceivedNotification(notification: Notification) {
        let tags = notification.userInfo?["tags"] as? [String]
        self.tags.removeAll()
        self.tags.append(contentsOf: tags ?? [])
        tagsCollection.reloadData()
        setupHistory()
    }

}
extension NewSearchContainerVC {
    @IBAction func removeAll(_ sender: Any) {
        SearchHistory().delete()
        setupHistory()
    }
    @IBAction func showMore(_ sender: Any) {
        isShowMore = !isShowMore
        setupHistory()
    }
}
// MARK: - ...  View Contract
extension NewSearchContainerVC: NewSearchContainerViewContract {
}

extension NewSearchContainerVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = tags[indexPath.row].widthWithConstrainedWidth(width: collectionView.width, font: ThemeApp.Fonts.regularFont(size: 18))
        return CGSize(width: width + 30, height: 30)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if tags.count >= 6 {
            return 6
        } else {
            return tags.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.cell(type: TagSearchCell.self, indexPath)
        cell.titleLbl.text = tags[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        reloadHeight()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: Notification.Name("SELECT_TEXT"), object: nil, userInfo: ["text": tags[indexPath.row]])
    }
}
extension NewSearchContainerVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isShowMore {
            return history.count
        } else {
            if history.count > 3 {
                return 3
            } else {
                return history.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.cell(type: SearchTableCell.self, indexPath)
        cell.titleLbl.text = history[indexPath.row]
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        reloadHeight()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        NotificationCenter.default.post(name: Notification.Name("SELECT_TEXT"), object: nil, userInfo: ["text": history[indexPath.row]])
    }
}
extension NewSearchContainerVC: SearchTableCellDelegate {
    func searchTableCell(didDelete cell: SearchTableCell) {
        SearchHistory().delete(text: history[cell.indexPath()])
        setupHistory()
    }
}
