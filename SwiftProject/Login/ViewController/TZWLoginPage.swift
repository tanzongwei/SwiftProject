//
//  TZWLoginPage.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/7/5.
//

import UIKit

class TZWLoginPage {

    static let share = TZWLoginPage()
    private init(){}
    
    func showLogin() {
        let loginVC = TZWLoginViewController()
        let navigationVC = TZWNavViewController(rootViewController: loginVC)
        navigationVC.modalPresentationStyle = .fullScreen
        if let topViewController = UIApplication.TZWApplicationWindow?.rootViewController as? TZWTabViewController {
            topViewController.present(navigationVC, animated: true)
        }
    }

}
