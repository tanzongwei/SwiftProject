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
        let loginVc = TZWLoginViewController()
        window?.rootViewController = loginVc
        window?.makeKeyAndVisible()
        return true
    }
    
    
    class func showLogin() {
        
//        let vc = TZWLoginViewController()
//        UIApplication.TZWApplicationWindow?.rootViewController = vc
    }
    
    
    
    
    
    


}

