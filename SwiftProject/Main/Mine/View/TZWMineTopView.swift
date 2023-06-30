//
//  TZWMineTopViw.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/6/30.
//

import UIKit

class TZWMineTopView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    func setUI() {
        self.addSubview(self.settingBtn)
        self.addSubview(self.shareBtn)
        
        self.settingBtn.snp.makeConstraints { make in
            make.right.equalTo(self).offset(-10)
            make.width.height.equalTo(36)
            make.bottom.equalTo(self.snp.bottom).offset(-6)
        }
        
        self.shareBtn.snp.makeConstraints { make in
            make.width.height.equalTo(36)
            make.right.equalTo(self.settingBtn.snp.left).offset(-12)
            make.centerY.equalTo(self.settingBtn)
        }
    }
    
    // MARK: 监听事件
    
    @objc func didPressShareBtn(btn: UIButton) {
        print("tag:",btn.tag)
    }
    
    @objc func didPressSettingBtn(btn: UIButton) {
        print("didPressSettingBtn")
    }
    
    // MARK: 懒加载
    
    lazy var shareBtn: UIButton = {
        let shareBtn = UIButton()
        shareBtn.setImage(UIImage(named: "mine_share"), for: .normal)
        shareBtn.tag = 100
        shareBtn.addTarget(self, action: #selector(didPressShareBtn), for: .touchUpInside)
        return shareBtn
    }()
    
    lazy var settingBtn: UIButton = {
        let settingBtn = UIButton()
        settingBtn.setImage(UIImage(named: "mine_setting"), for: .normal)
        settingBtn.addTarget(self, action: #selector(didPressSettingBtn), for: .touchUpInside)
        return settingBtn
    }()
}
