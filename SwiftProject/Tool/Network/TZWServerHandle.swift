//
//  TZWServerHandle.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/7/4.
//

import UIKit

class TZWServerHandle {

    class func getSecret(params:[String: Any]) -> [String: Any] {
        var par = params
        par["osType"] = "ios"
        var ctime = String.init(Int(Date.init().timeIntervalSince1970 * 1000))
        par["ctime"] = ctime
        par["appName"] = "camhomme_iphone"
        par["isEnc"] = 0
        par["version"] = "3.18.1"
        par["deviceMark"] = "abcd1234"
        return par
    }

}
