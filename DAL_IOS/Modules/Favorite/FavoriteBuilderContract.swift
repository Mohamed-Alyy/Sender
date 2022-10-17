//
//  FavoriteBuilderContracts.swift
//  DAL_IOS
//
//  Created by M.abdu on 1/21/21.
//  Copyright © 2021 com.M.Abdu. All rights reserved.
//

import Foundation

// MARK: - ...  Presenter Contract
protocol FavoriteBuilderPresenterContract: PresenterProtocol {
    func like()
}
// MARK: - ...  View Contract
protocol FavoriteBuilder {
    var id: Int? { get set }
    var isLiked: Int? { get set }
    mutating func swipeLike()
    mutating func didLike()
    mutating func like()
    func liked() -> Bool
}

extension FavoriteBuilder {
    mutating func like() {
        let presenter = FavoriteBuilderPresenter()
        presenter.view = self
        presenter.like()
        swipeLike()
    }
    mutating func swipeLike() {
        if isLiked == 1 {
            isLiked = 0
        } else {
            isLiked = 1
        }
    }
    mutating func didLike() {
        isLiked = 0
    }
    func liked() -> Bool {
        return isLiked == 1
    }
}
