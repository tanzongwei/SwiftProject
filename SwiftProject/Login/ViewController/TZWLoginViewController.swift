//
//  TZWLoginViewController.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/6/29.
//

import UIKit
import Moya

class TZWLoginViewController: TZWBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI() {
        self.view.backgroundColor = UIColor.white
        view.addSubview(bgImageView)
        bgImageView.addSubview(backButton)
        bgImageView.addSubview(phoneLabel)
        bgImageView.addSubview(phoneView)
        bgImageView.addSubview(checkLoginBtn)
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        
        backButton.snp.makeConstraints { make in
            make.left.equalTo(16);
            make.width.height.equalTo(44)
            make.top.equalTo(SL_SAFE_AREA_INSETS_TOP)
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.top.equalTo(self.view).offset(16.0 + SL_SAFE_AREA_INSETS_TOP + TZWNAVHEIGHT)
        }
        
        phoneView.snp.makeConstraints { make in
            make.left.equalTo(28)
            make.right.equalTo(-28)
            make.height.equalTo(56)
            make.top.equalTo(phoneLabel.snp.bottom).offset(44)
        }
        
        checkLoginBtn.snp.makeConstraints { make in
            make.left.equalTo(phoneView.snp.left)
            make.right.equalTo(phoneView.snp.right)
            make.height.equalTo(48)
            make.top.equalTo(phoneView.snp.bottom).offset(44)
        }
    }
    
    // MARK: 监听事件
    
    @objc func didPressBackBtn() {
        
    }
    
    @objc func didPressCheckLoginBtn() {
        _ = MoyaProvider<TZWUserServer>().TZWNetWorkRequest(.loginCheckPhone(phone: phoneView.phoenTextField.text)).done
        {(result:Bool?) in
            if result! {
                
            }
        }
    }
    
    // MARK: 懒加载
    
    lazy var bgImageView: UIImageView = {
        let iconView = UIImageView()
        iconView.image = UIImage(named: "login_bg")
        iconView.contentMode = .scaleAspectFit
        iconView.isUserInteractionEnabled = true
        return iconView
    }()
    
    lazy var backButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "login_back"), for: .normal)
        btn.addTarget(self, action: #selector(didPressBackBtn), for: .touchUpInside)
        return btn
    }()
    
    lazy var phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        phoneLabel.textColor = UIColor.init(hexString: "#1A1A1A")
        phoneLabel.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.medium)
        phoneLabel.text = "手机号验证"
        return phoneLabel
    }()
    
    lazy var phoneView: TZWLoginPhoneView = {
        let phoneView = TZWLoginPhoneView(frame: CGRectZero)
        phoneView.layer.cornerRadius = 8.0
        phoneView.clipsToBounds = true
        return phoneView
    }()

    lazy var checkLoginBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("验证并登录", for: .normal)
        btn.setBackgroundColor(UIColor.init(hexString: "#2727D9"), for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        btn.layer.cornerRadius = 24
        btn.addTarget(self, action: #selector(didPressCheckLoginBtn), for: .touchUpInside)
        btn.clipsToBounds = true
        return btn
    }()
}
