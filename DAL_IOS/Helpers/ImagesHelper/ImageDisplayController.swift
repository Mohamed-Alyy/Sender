//
//  ImageDisplayController.swift
//  SupportI
//
//  Created by mohamed abdo on 9/2/19.
//  Copyright © 2019 MohamedAbdu. All rights reserved.
//
import UIKit
protocol ImageDisplayInterface: class {
    func displayImage(image: String?)
    func displayImage(image: UIImage?)
}
extension ImageDisplayInterface where Self: UIViewController {
    func displayImage(image: String?) {
        let storyboard = UIStoryboard(name: "ImageDisplayController", bundle: nil)
        guard let popOverVC = storyboard.instantiateViewController(withIdentifier: "ImageDisplayController") as? ImageDisplayController else { return }
        popOverVC.mode = .url
        popOverVC.imageURL = image
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
    func displayImage(image: UIImage?) {
        let storyboard = UIStoryboard(name: "ImageDisplayController", bundle: nil)
        guard let popOverVC = storyboard.instantiateViewController(withIdentifier: "ImageDisplayController") as? ImageDisplayController else { return }
        popOverVC.mode = .image
        popOverVC.uiImage = image
        self.addChild(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: self)
    }
}
extension ImageDisplayInterface {
    func displayImage(view: UIViewController?, image: String?) {
        guard let view = view else { return }
        let storyboard = UIStoryboard(name: "ImageDisplayController", bundle: nil)
        guard let popOverVC = storyboard.instantiateViewController(withIdentifier: "ImageDisplayController") as? ImageDisplayController else { return }
        popOverVC.mode = .url
        popOverVC.imageURL = image
        view.addChild(popOverVC)
        popOverVC.view.frame = view.view.frame
        view.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: view)
    }
    func displayImage(view: UIViewController?, image: UIImage?) {
        guard let view = view else { return }
        let storyboard = UIStoryboard(name: "ImageDisplayController", bundle: nil)
        guard let popOverVC = storyboard.instantiateViewController(withIdentifier: "ImageDisplayController") as? ImageDisplayController else { return }
        popOverVC.mode = .image
        popOverVC.uiImage = image
        view.addChild(popOverVC)
        popOverVC.view.frame = view.view.frame
        view.view.addSubview(popOverVC.view)
        popOverVC.didMove(toParent: view)
    }
    func displayImage(image: String?) {
        
    }
    func displayImage(image: UIImage?) {
        
    }
}
class ImageDisplayController: UIViewController {
    enum Mode {
        case url
        case image
    }
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var superView: UIView!
    var imageURL: String?
    var uiImage: UIImage?
    var mode: Mode = .url
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        self.showAnimate()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        // 2. add the gesture recognizer to a view
        superView.addGestureRecognizer(tapGesture)
        self.view.UIViewAction { [weak self] in
            self?.removeAnimate()
        }
        if mode == .url {
            image.setImage(url: imageURL)
        } else {
            image.image = uiImage
        }
        // Do any additional setup after loading the view.
    }
    @objc func handleTap(sender: UITapGestureRecognizer) {
        removeAnimate()
    }
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        })
    }
    func removeAnimate(closure: HandlerView? = nil) {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0
        }, completion: {(finished: Bool)  in

            if finished {
                self.view.removeFromSuperview()
                closure?()
            }

        })
    }
}
