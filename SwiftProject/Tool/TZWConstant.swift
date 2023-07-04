//
//  TZWConstant.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/6/30.
//

import UIKit
import SnapKit

public func SLSafeAreaInsets() -> UIEdgeInsets {
    
    let window = UIApplication.shared.windows.last
    var insets:UIEdgeInsets = UIEdgeInsets.zero
    
    if #available(iOS 11.0, *) {
        insets = window?.safeAreaInsets ?? UIEdgeInsets.zero;
    }
    return insets;
}

public func SLMainThreadSafeAreaInsets() -> UIEdgeInsets {
    var insets: UIEdgeInsets = UIEdgeInsets.zero;
    
    if (Thread.isMainThread) {
        insets = SLSafeAreaInsets();
    } else {
        DispatchQueue.main.async {
            insets = SLSafeAreaInsets();
        }
    }
    return insets;
}

//安全域
let SL_SAFE_AREA_INSETS = SLMainThreadSafeAreaInsets()

let SL_SAFE_AREA_INSETS_TOP = SL_SAFE_AREA_INSETS.top
let SL_SAFE_AREA_INSETS_BOTTOM  = SL_SAFE_AREA_INSETS.bottom

let SL_SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SL_SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SL_SCREEN_BOUNDS = UIScreen.main.bounds
let TZWNAVHEIGHT = 44.0

class TZWConstant: NSObject {

}
