//
//  TZWPageView.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/7/10.
//

import UIKit

class TZWMessageTopPageView: UIView,TZWMessageTopItemViewDelegate {
    var delegate: TZWMessageTopPageViewDelegate?
    var dataSources: [TZWMessageTopItemModel] = []
    var itemSource: [TZWMessageTopItemView] = []
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    func setUI() {
        dataSources = loadData()
        let x = 48.0
        let width = (SL_SCREEN_WIDTH - 2*48)/3.0
        for (index,itemModel) in dataSources.enumerated() {
            let item = TZWMessageTopItemView(frame: CGRectMake(x + (CGFloat(index) * width), 0, width, self.height))
            item.setItemBtnTitle(index: index, itemModel: itemModel)
            item.delegate = self
            self.addSubview(item)
            itemSource.append(item)
        }
        
        self.addSubview(clearBtn)
    }
    
    private func loadData() -> [TZWMessageTopItemModel] {
        let source = ["通知","评论","私信"]
        var dataSource: [TZWMessageTopItemModel] = []
        for (index,title) in source.enumerated() {
            let itemModel = TZWMessageTopItemModel()
            itemModel.index = index
            itemModel.title = title
            if (index == 0) {
                itemModel.isSelect = true
            }
            dataSource.append(itemModel)
        }
        return dataSource
    }
    
    lazy var clearBtn: UIButton = {
        let btn = UIButton(frame: CGRectMake(SL_SCREEN_WIDTH-48, 4, 36, 36))
        btn.setImage(UIImage(named: "message_clear"), for: .normal)
        return btn
    }()
}

protocol TZWMessageTopPageViewDelegate {
    func clickTopPage(itemModel: TZWMessageTopItemModel)
}

extension TZWMessageTopPageView {
    func didPressItemModel(btn: UIButton) {
        let btnIndex = btn.tag
        for (index,itemModel) in dataSources.enumerated() {
            itemModel.isSelect = false
            let item = itemSource[index]
            item.updateSelectView(itemModel: itemModel)
        }
        let selectItemModel = dataSources[btnIndex]
        selectItemModel.isSelect = true
        let item = itemSource[btnIndex]
        item.updateSelectView(itemModel: selectItemModel)
        self.delegate?.clickTopPage(itemModel: selectItemModel)
    }
}
