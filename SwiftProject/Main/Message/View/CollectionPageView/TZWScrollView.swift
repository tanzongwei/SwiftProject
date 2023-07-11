//
//  TZWScrollView.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/7/11.
//

import UIKit

class TZWScrollView: UIScrollView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
    
    func setUI() {
//        self.backgroundColor = UIColor.yellow
    }

}
