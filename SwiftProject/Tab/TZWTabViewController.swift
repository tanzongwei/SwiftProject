//
//  TZWTabViewController.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/6/30.
//

import UIKit

class TZWTabViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
       setUI()
    }
    
    func setUI() {
        let homeVC = TZWHomeViewController()
        let communityVC = TZWCommunityViewController()
        let messageVC = TZWMessageViewController()
        let mineVC = TZWMineViewController()
        
        let homeNav = TZWNavViewController(rootViewController: homeVC)
        let communityNav = TZWNavViewController(rootViewController: communityVC)
        let messageNav = TZWNavViewController(rootViewController: messageVC)
        let mineNav = TZWNavViewController(rootViewController: mineVC)
        
        homeNav.tabBarItem = createItem(imageName: "tab_home", title: "创作")
        communityNav.tabBarItem = createItem(imageName: "tab_community", title: "灵感")
        messageNav.tabBarItem = createItem(imageName: "tab_message", title: "消息")
        mineNav.tabBarItem = createItem(imageName: "tab_mine", title: "我")
        
        viewControllers = [homeNav,communityNav,messageNav,mineNav]
        self.tabBar.backgroundColor = UIColor.clear
    }
    
    func createItem(imageName: String,title: String) -> UITabBarItem {
        let item = UITabBarItem()
        item.title = title
        let norImageName = imageName.appending("_nor")
        let selImageName = imageName.appending("_sel")
        item.image = UIImage(named: norImageName)?.withRenderingMode(.alwaysOriginal)
        item.selectedImage = UIImage(named: selImageName)?.withRenderingMode(.alwaysOriginal)
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.init(hexString: "#999999")!,
            .font: UIFont.systemFont(ofSize: 10, weight: .medium)
        ]
        var selectColor = "#333333"
        if title == "创作" {
            selectColor = "#FFFFFF"
        }
        let selectAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.init(hexString: selectColor)!,
            .font: UIFont.systemFont(ofSize: 10, weight: .medium)
        ]
        item.setTitleTextAttributes(normalAttributes, for: .normal)
        item.setTitleTextAttributes(selectAttributes, for: .selected)
        return item
    }
    
    // MARK: 懒加载
    
}

extension TZWTabViewController {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if (tabBarController.selectedIndex == 0) {
            self.tabBar.backgroundColor = UIColor.clear
        } else {
            self.tabBar.backgroundColor = UIColor.white
        }
    }
}
