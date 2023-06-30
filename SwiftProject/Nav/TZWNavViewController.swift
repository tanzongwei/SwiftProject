//
//  TZWNavViewController.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/6/30.
//

import UIKit

class TZWNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        setUI()
    }
    
    private func setUI() {
//        self.view.addSubview(self.backButton)
//        
//        self.backButton.snp.makeConstraints { make in
//            make.left.equalTo(16)
//            make.height.width.equalTo(44)
//            make.top.equalTo(SL_SAFE_AREA_INSETS_TOP)
//        }
    }
    
    // MARK:监听事件
   @objc func didPressBackBtn() {
        print("点击返回")
    }
    
    // MARK: 懒加载
    lazy var backButton: UIButton = {
        let backBtn = UIButton()
        backBtn.setImage(UIImage(named: "nav_back"), for: .normal)
        backBtn.addTarget(self, action: #selector(didPressBackBtn), for: .touchUpInside)
        return backBtn
    }()
}

protocol HideNavigationBarProtocol where Self: UIViewController {}

extension TZWNavViewController : UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if (viewController is HideNavigationBarProtocol) {
            self.setNavigationBarHidden(true, animated: animated)
        } else {
            self.setNavigationBarHidden(false, animated: animated)
        }
    }
}
