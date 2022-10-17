//
//  POPUPViewController.swift
//
//  Created by mohamed abdo on 6/2/18.
//

import Foundation
import UIKit
// MARK: - ...  Protocol to open view as a pop up view
protocol POPUPModal {
    func pushPop(_ scene: UIViewController)
}
// MARK: - ...  Protocol to open view as a pop up view
extension POPUPModal where Self: BaseController {
    func pushPop(_ scene: UIViewController) {
        let topVC = UIApplication.topMostController()
        scene.modalPresentationStyle = .overFullScreen
        scene.view.backgroundColor = UIColor.black.withAlphaComponent(0.70)
        let transition = CATransition()
        transition.duration = 0.2
        transition.type = CATransitionType.fade
        topVC.view.window?.layer.add(transition, forKey: kCATransition)
        topVC.present(scene, animated: false, completion: nil)
    }
}
// MARK: - ...  Protocol to open view as a pop up view
extension BaseController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}
