//
//  TZWApplicationWindow.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/6/29.
//

import UIKit

extension UIApplication {
    static var TZWApplicationWindow: UIWindow? {
        return UIApplication.shared.delegate?.window?.flatMap{$0}
    }
}

