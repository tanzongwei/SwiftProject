//
//  TZWLoginViewController.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/6/29.
//

import UIKit

class TZWLoginViewController: TZWBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI() {
        self.view.backgroundColor = UIColor.white
        view.addSubview(self.headIcon)
        
    }
    
    lazy var headIcon: UIImageView = {
        let iconView = UIImageView()
        iconView.image = UIImage(named: "login_icon_180")
        return iconView
    }()

}
