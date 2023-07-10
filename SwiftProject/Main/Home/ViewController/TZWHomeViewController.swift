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
        view.backgroundColor = UIColor.gray
        view.addSubview(loginBtn)
        view.addSubview(loginOutBtn)
    }
    
    @objc func didPressLoginBtn() {
        TZWLoginPage.share.showLogin()

    }
    
    @objc func didPressLoginOut() {
        TZWUser.loginOut()
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
    
    lazy var loginOutBtn: UIButton = {
        let loginOutBtn = UIButton(frame: CGRectMake(20, loginBtn.bottom + 20, loginBtn.width, loginBtn.height))
        loginOutBtn.setBackgroundColor(UIColor.blue, for: .normal)
        loginOutBtn.setTitle("退出登录", for: .normal)
        loginOutBtn.addTarget(self, action: #selector(didPressLoginOut), for: .touchUpInside)
        loginOutBtn.layer.cornerRadius = 4
        loginOutBtn.clipsToBounds = true
        return loginOutBtn
    }()
}
