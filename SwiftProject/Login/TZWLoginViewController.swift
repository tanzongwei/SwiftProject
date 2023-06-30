//
//  TZWLoginViewController.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/6/29.
//

import UIKit

class TZWLoginViewController: TZWBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
    }
    
    func setUI() {
        self.view.backgroundColor = UIColor.white
        view.addSubview(self.headIcon)
        view.addSubview(self.phoneLabel)
        
        self.headIcon.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        
        self.phoneLabel.snp.makeConstraints { make in
            make.left.equalTo(30)
            make.top.equalTo(self.view).offset(16)
        }
    }
    
    lazy var headIcon: UIImageView = {
        let iconView = UIImageView()
        iconView.image = UIImage(named: "login_bg")
        return iconView
    }()
    
    lazy var phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        phoneLabel.textColor = UIColor.init(hexString: "#1A1A1A")
        phoneLabel.font = UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.medium)
        phoneLabel.text = "手机号验证"
        return phoneLabel
    }()

    lazy var phoneField: UITextField = {
        let phoneField = UITextField()
        phoneField.placeholder = "请输入手机号"
        phoneField.font = UIFont.systemFont(ofSize: 16)
        phoneField.textColor = UIColor.init(hexString: "")
        return phoneField
    }()
}
