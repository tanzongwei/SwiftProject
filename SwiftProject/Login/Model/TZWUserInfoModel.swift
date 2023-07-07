//
//  TZWUserInfoModel.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/7/4.
//

import UIKit

struct TZWUserInfoModel: Codable {
    var userId: String?
    var accessToken: String?
    var refreshToken: String?
    var expireTime: Int?
    var appId: Int?
    var addTime: Int?
    var updateTime: Int?
}
