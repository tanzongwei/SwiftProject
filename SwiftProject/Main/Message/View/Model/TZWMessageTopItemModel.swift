//
//  TZWMessageTopItemModel.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/7/10.
//

import UIKit

class TZWMessageTopItemModel {
    var isSelect:Bool?
    var title: String?
    
    init(isSelect: Bool? = nil, title: String? = nil) {
        self.isSelect = isSelect
        self.title = title
    }
}
