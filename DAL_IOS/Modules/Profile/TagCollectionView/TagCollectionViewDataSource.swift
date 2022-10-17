//
//
//  Created by M.abdu on 11/8/20.
//

import Foundation
import UIKit

protocol TagCollectionViewDataSource: NSObjectProtocol {
    func tagCollectionView(for collection: TagCollectionView?) -> [TagModel]
}

extension TagCollectionViewDataSource {

}

protocol TagCollectionViewDelegate: NSObjectProtocol {
    func tagCollectionView(for TagCollectionView: TagCollectionView?, at didSelectItem: Int)
}

extension TagCollectionViewDelegate {
    func tagCollectionView(for TagCollectionView: TagCollectionView?, at didSelectItem: Int) {
        
    }
}
