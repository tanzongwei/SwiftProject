//
//  TZWMessageTopItemView.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/7/10.
//

import UIKit

class TZWMessageTopItemView: UIView {
    
    public var delegate:TZWMessageTopItemViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    private func setUI() {
        self.addSubview(itemBtn)
        self.addSubview(numLabel)
    }
    
    @objc func didPressItem(btn: UIButton) {
        if btn.isSelected {
            return
        }
        self.delegate?.didPressItemModel(btn: btn)
    }
    
    func updateSelectView(itemModel: TZWMessageTopItemModel) {
        itemBtn.isSelected = itemModel.isSelect ?? false
    }
    
    func setItemBtnTitle(index: Int,itemModel: TZWMessageTopItemModel) {
        itemBtn.setTitle(itemModel.title, for: .normal)
        itemBtn.isSelected = itemModel.isSelect ?? false
        itemBtn.tag = index
    }
    
    func setNumber(num: Int) {
        guard num > 0 else {
            numLabel.isHidden = true
            return
        }
        numLabel.isHidden = false
        numLabel.text = String(num)
        if num > 99 {
            numLabel.width = 32
        } else {
            numLabel.width = 18
        }
    }
    
    lazy var itemBtn: UIButton = {
        let btn = UIButton(frame: self.bounds)
        btn.setTitleColor(UIColor.init(hexString: "#999999"), for: .normal)
        btn.setTitleColor(UIColor.init(hexString: "#333333"), for: .selected)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        btn.addTarget(self, action: #selector(didPressItem), for: .touchUpInside)
        btn.showsTouchWhenHighlighted = false
        return btn
    }()
    
    lazy var numLabel: UILabel = {
        let label = UILabel(frame: CGRectMake(itemBtn.centerX+18, 9, 18, 18))
        label.backgroundColor = UIColor.init(hexString: "#FE3B30")
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor.init(hexString: "#FFFFFF")
        label.textAlignment = .center
        label.layer.cornerRadius = 9
        label.clipsToBounds = true
        label.isHidden = true
        return label
    }()
}

protocol TZWMessageTopItemViewDelegate {
    func didPressItemModel(btn: UIButton)
}
