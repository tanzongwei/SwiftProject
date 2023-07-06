//
//  AppDelegate.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/6/29.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        showMainUI()
        
        window?.makeKeyAndVisible()
        return true
    }
    
    func showMainUI() {
        self.window?.rootViewController = TZWTabViewController()
    }
    
    
    class func showLogin(isLogin: Bool) {
//        if isLogin {
//            let vc = TZWLoginViewController()
//            let nav = TZWNavViewController(rootViewController: vc)
//            UIApplication.TZWApplicationWindow?.rootViewController = nav
//        } else {
//            let tab = TZWTabViewController()
//            UIApplication.TZWApplicationWindow?.rootViewController = tab
//        }

    }
    
    
    
    
    
    


}

