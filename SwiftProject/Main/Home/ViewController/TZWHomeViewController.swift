//
//  TZWHomeViewController.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/6/30.
//

import UIKit

class TZWHomeViewController: TZWBaseViewController,HideNavigationBarProtocol {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
    }
    
    func setUI() {
        view.backgroundColor = UIColor.white
        view.addSubview(loginBtn)
    }
    
    @objc func didPressLoginBtn() {
        TZWLoginPage.share.showLogin()

    }
    
    lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(frame: CGRectMake(20, 100, SL_SCREEN_WIDTH - 40, 50))
        loginBtn.setBackgroundColor(UIColor.blue, for: .normal)
        loginBtn.setTitle("登录", for: .normal)
        loginBtn.addTarget(self, action: #selector(didPressLoginBtn), for: .touchUpInside)
        loginBtn.layer.cornerRadius = 4
        loginBtn.clipsToBounds = true
        return loginBtn
    }()
}
