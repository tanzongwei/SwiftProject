//
//  TZWInputPasswordViewController.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/7/6.
//

import UIKit

class TZWInputPasswordViewController: TZWBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    private func setUI() {
        view.backgroundColor = UIColor.white
        
        view.addSubview(pwdLabel)
        view.addSubview(pwdView)
        view.addSubview(findPwdBtn)
        view.addSubview(loginBtn)
        
        pwdLabel.snp.makeConstraints { make in
            make.left.equalTo(28)
            make.top.equalTo(SL_SAFE_AREA_INSETS_TOP_NAVHEIGHT + 12)
        }
        
        pwdView.snp.makeConstraints { make in
            make.left.equalTo(28)
            make.right.equalTo(-28)
            make.height.equalTo(56)
            make.top.equalTo(pwdLabel.snp_bottomMargin).offset(44)
        }
        
        findPwdBtn.snp.makeConstraints { make in
            make.right.equalTo(pwdView.snp.right)
            make.top.equalTo(pwdView.snp.bottom).offset(12)
            make.height.equalTo(20)
            make.width.equalTo(60)
        }
        
        loginBtn.snp.makeConstraints { make in
            make.left.equalTo(pwdView.snp.left)
            make.right.equalTo(pwdView.snp.right)
            make.height.equalTo(48)
            make.top.equalTo(pwdView.snp.bottom).offset(68)
        }
    }
    
    // MARK: 事件处理
    @objc private func didPressLoginBtn() {
        print("点击登录按钮")
        NotificationCenter.default.post(name: Notification.Name("leaveLoginNotification"), object: nil)
    }
    
    // MARK: 懒加载
    
    lazy var pwdLabel: UILabel = {
        let label = UILabel()
        label.text = "请输入密码"
        label.textColor = UIColor.init(hexString: "#1A1A1A")
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    
    lazy var pwdView: TZWLoginPwdView = {
        let view = TZWLoginPwdView(frame: CGRectZero)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    lazy var findPwdBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("找回密码", for: .normal)
        btn.setTitleColor(UIColor.init(hexString: "#2727D9"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        btn.contentHorizontalAlignment = .right
        return btn
    }()
    
    lazy var loginBtn: UIButton = {
        let btn = UIButton()
        btn.setBackgroundColor(UIColor.init(hexString: "#2727D9"), for: .normal)
        btn.setTitle("登录", for: .normal)
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        btn.addTarget(self, action: #selector(didPressLoginBtn), for: .touchUpInside)
        btn.layer.cornerRadius = 24
        btn.clipsToBounds = true
        return btn
    }()

}
