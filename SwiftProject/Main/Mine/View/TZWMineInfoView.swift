//
//  TZWMineInfoView.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/7/3.
//

import UIKit

class TZWMineInfoView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        self.addSubview(userIconBtn)
        self.addSubview(nameLabel)
    }
    
    // MARK:监听事件
    
    @objc func didPressUserIcon(btn: UIButton) {
        
    }
    
    lazy var userIconBtn: UIButton = {
        let btn = UIButton(frame: CGRectMake((SL_SCREEN_WIDTH - 100)/2, 30, 100, 100))
        btn.layer.cornerRadius = 50
        btn.clipsToBounds = true
        btn.layer.borderWidth = 0.5
        btn.layer.borderColor = UIColor.white.cgColor
        btn.setImage(UIImage(named: "user_icon"), for: .normal)
        btn.addTarget(self, action: #selector(didPressUserIcon), for: .touchUpInside)
        return btn
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: CGRectMake(16, self.userIconBtn.bottom + 8, SL_SCREEN_WIDTH - 16*2, 28))
        label.textAlignment = .center
        label.text = "测试"
        return label
    }()

}
