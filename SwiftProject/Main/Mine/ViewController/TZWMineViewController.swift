//
//  TZWMineViewController.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/6/30.
//

import UIKit

class TZWMineViewController: UIViewController,HideNavigationBarProtocol {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.topView)
        
        self.topView.snp.makeConstraints { make in
            make.left.right.top.equalTo(self.view)
            make.height.equalTo(44 + SL_SAFE_AREA_INSETS_TOP)
        }
    }

    // MARK:懒加载
    
    lazy var topView: TZWMineTopView = {
        let topView = TZWMineTopView(frame: CGRectZero)
        return topView
    }()

}
