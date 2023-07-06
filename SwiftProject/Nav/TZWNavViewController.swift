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
        
        let backButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backButtonItem
    }
    
    // MARK:监听事件
   @objc func didPressBackBtn() {
       self.popViewController(animated: true)
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
//
extension TZWNavViewController : UINavigationControllerDelegate {
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        let backButtonItem = UIBarButtonItem(customView: backButton)
        viewController.navigationItem.leftBarButtonItem = backButtonItem
        super.pushViewController(viewController, animated: animated)
    }

    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if (viewController is HideNavigationBarProtocol) {
            self.setNavigationBarHidden(true, animated: animated)
        } else {
            self.setNavigationBarHidden(false, animated: animated)
        }
    }
}
