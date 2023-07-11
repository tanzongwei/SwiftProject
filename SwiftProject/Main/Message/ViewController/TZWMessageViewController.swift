//
//  TZWMessageViewController.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/6/30.
//

import UIKit

class TZWMessageViewController: TZWBaseViewController,HideNavigationBarProtocol {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard TZWUser.isLogin() else {
            TZWLoginPage.share.showLogin()
            return
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addNotification()
        setUI()
        
    }
    
    func setUI() {
        self.view.backgroundColor = UIColor.white
        view.addSubview(pageView)
    }
    
    // MARK: 通知处理
    
    private func addNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(didPressLoginBack), name: Notification.Name(rawValue: TZWClickLoginBackName), object: nil)
    }
    
    @objc func didPressLoginBack() {
        if let array = navigationController?.viewControllers {
            for viewController in array {
                if viewController.isKind(of: TZWMessageViewController.self) {
                    self.tabBarController?.selectedIndex = 1
                }
            }
        }

    }
    
    // MARK: 懒加载
    
    lazy var pageView: TZWMessageTopPageView = {
        let pageView = TZWMessageTopPageView(frame: CGRectMake(0, SL_SAFE_AREA_INSETS_TOP, SL_SCREEN_WIDTH, 44))
        return pageView
    }()

}
