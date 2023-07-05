//
//  TZWLoginPhoneView.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/7/4.
//

import UIKit

class TZWLoginPhoneView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    func setUI() {
        self.backgroundColor = UIColor.init(hexString: "#F5F5F5")
        self.addSubview(areaCodeBtn)
        self.addSubview(phoenTextField)
        
        areaCodeBtn.snp.makeConstraints { make in
            make.left.equalTo(18)
            make.width.equalTo(46)
            make.top.bottom.equalTo(self)
        }
        
        phoenTextField.snp.makeConstraints { make in
            make.left.equalTo(areaCodeBtn.snp.right).offset(23)
            make.right.equalTo(-15)
            make.top.bottom.equalTo(self)
        }
    }
    
    // MARK: 懒加载
    
    lazy var areaCodeBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("+86", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
        btn.setTitleColor(UIColor.init(hexString: "#666666"), for: .normal)
        btn.setImage(UIImage(named: "login_down_select"), for: .normal)
        btn.layoutButton(with: MKButtonEdgeInsetsStyle(rawValue: 3)!, imageTitleSpace: 17)
        return btn
    }()

    lazy var phoenTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "请输入手机号"
        textField.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        textField.textColor = UIColor.init(hexString: "#1A1A1A")
        textField.clearButtonMode = .whileEditing
        textField.keyboardType = .numberPad
        textField.text = "18000000152"
        return textField
    }()
}
