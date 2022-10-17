//
//
//  Created by M.abdu on 11/8/20.
//

import Foundation
import UIKit

protocol FilterViewDataSource: NSObjectProtocol {
    func filterView(for filter: FilterView?) -> [FilterModel]
}

protocol FilterViewDelegate: NSObjectProtocol {
    func filterView(for filter: FilterView?, at didSelectItem: Int)
}

extension FilterViewDelegate {
    func filterView(for filter: FilterView?, at didSelectItem: Int) {

    }
}
