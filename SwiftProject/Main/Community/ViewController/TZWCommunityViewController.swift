//
//  TZWCommunityViewController.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/7/6.
//

import UIKit

class TZWCommunityViewController: TZWBaseViewController,HideNavigationBarProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
    }
    
    private func setUI() {
        view.backgroundColor = UIColor.white
    }

}
