//
//  ProviderOrdersVC.swift
//  DAL_IOS
//
//  Created by Diaa SALAM on 17/10/2022.
//  Copyright © 2022 com.M.Abdu. All rights reserved.
//

import UIKit

class ProviderOrdersVC: UIViewController {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginVC")
        navigationController?.pushViewController(vc, animated: true)
        
        let vc2 = ProviderLoginVC.loadFromNib()
        present(vc2, animated: true)
        navigationController?.pushViewController(vc2, animated: true)
    }
 
}
