//
//  TZWTabViewController.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/6/30.
//

import UIKit

class TZWTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
       setUI()
    }
    
    func setUI() {
        let homeVC = TZWHomeViewController()
        let messageVC = TZWMessageViewController()
        let mineVC = TZWMineViewController()
        
        let homeNav = TZWNavViewController(rootViewController: homeVC)
        let messageNav = TZWNavViewController(rootViewController: messageVC)
        let mineNav = TZWNavViewController(rootViewController: mineVC)
        
        homeNav.tabBarItem = UITabBarItem(title: "创作", image: UIImage(named: "tab_home_nor"), tag: 0)
        messageNav.tabBarItem = UITabBarItem(title: "消息", image: UIImage(named: "tab_message_nor"), tag: 1)
        mineNav.tabBarItem = UITabBarItem(title: "我", image: UIImage(named: "tab_mine_nor"), tag: 2)
        
        viewControllers = [homeNav,messageNav,mineNav]
        
    }
    
    // MARK: 懒加载
    
    

}
