//
//  BaseController.swift
//
//  Created by mohamed abdo on 3/25/18.
//

import UIKit

class BaseController: UIViewController, POPUPModal {
    
    @IBOutlet weak var menuBtnButton: UIButton!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    //This property for hide and unhide navigation bar
    var hideNav: Bool = false
    var cart: CartBuilder!
    var emptyScreen: EmptyScreen!
    // This action for any back for all pages
    @IBAction dynamic func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.removeSubviews()
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.setupBase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.hideNav {
            // hide the Navigation Bar
            self.navigationController?.setNavigationBarHidden(true, animated: false )
            self.navigationController?.navigationBar.shadowImage = UIImage()
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
        self.navigationController?.navigationBar.removeSubviews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.hideNav {
            // hide the Navigation Bar
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            
        } else {
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
    }
    func validate(txfs: [UITextField]) -> Bool {
        var validate = true
        txfs.forEach { (item) in
            if case item.text?.isEmptyOrWhitespace() = true {
                item.attributedPlaceholder = NSAttributedString(string: item.placeholder ?? "",
                                                                attributes: [NSAttributedString.Key.foregroundColor:UIColor.red])
                validate = false
            }
        }
        return validate
    }
}

extension BaseController: BaseViewControllerProtocol, PresentingViewProtocol, Alertable {
    func setupBase() {
        if menuBtnButton != nil {
            MenuHelper.instance.setUpMenuButton(delegate: self, menuBtn: menuBtnButton)
        }
        if menuBtn != nil {
            MenuHelper.instance.setUpMenuButton(delegate: self, menuBtn: menuBtn)
        }
        //reset paginator
        NetworkManager.instance.resetPaginate()
        //binding
        cart = .init()
    }
    
    func showEmptyScreen(title: String? = "Empty screen", body: String? = nil) {
        emptyScreen = EmptyScreen()
        emptyScreen.titleLbl.text = title?.localized
        emptyScreen.bodyLbl.text = body?.localized
        emptyScreen.container.backgroundColor = self.view.backgroundColor
        self.view.addSubview(emptyScreen)
        emptyScreen.addTopConstraint(toView: view, constant: 150)
        emptyScreen.addLeadingConstraint(toView: view)
        emptyScreen.addTrailingConstraint(toView: view)
        emptyScreen.addBottomConstraint(toView: view, constant: 0)
    }
    func hideEmptyScreen() {
        if emptyScreen != nil && emptyScreen.superview != nil {
            emptyScreen.removeFromSuperview()
        }
    }
}

