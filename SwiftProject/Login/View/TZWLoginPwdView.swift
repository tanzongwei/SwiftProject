//
//  TZWLoginPwdView.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/7/6.
//

import UIKit

class TZWLoginPwdView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    private func setUI() {
        self.backgroundColor = UIColor.init(hexString: "#F5F5F5")
        self.addSubview(pwdTextField)
        self.addSubview(showPwdBtn)
        
        pwdTextField.snp.makeConstraints { make in
            make.left.equalTo(16)
            make.top.bottom.equalTo(self)
            make.right.equalTo(-16-20)
        }
        
        showPwdBtn.snp.makeConstraints { make in
            make.right.equalTo(-16)
            make.width.height.equalTo(20)
            make.centerY.equalTo(self)
        }
        
    }
    
    // MARK: 事件监听
    
    @objc func didPressPwdBtn(btn: UIButton) {
        btn.isSelected = !btn.isSelected
        pwdTextField.isSecureTextEntry = !btn.isSelected
    }
    
    // MARK: 懒加载
    
    lazy var pwdTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入密码"
        textField.textColor = UIColor.init(hexString: "#1A1A1A")
        textField.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        textField.text = "beauty123"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var showPwdBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "login_pwd_show"), for: .selected)
        btn.setImage(UIImage(named: "login_pwd_hidden"), for: .normal)
        btn.addTarget(self, action: #selector(didPressPwdBtn), for: .touchUpInside)
        return btn
    }()

}
