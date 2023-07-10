//
//  TZWUserSet.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/7/10.
//

import UIKit
import Moya

struct TZWUser:Codable {
    var userId: String?
    var accessToken: String?
    var refreshToken: String?
    var expireTime: Int?
    var appId: Int?
    var addTime: Int?
    var updateTime: Int?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.userId = try container.decodeIfPresent(String.self, forKey: .userId)
        self.accessToken = try container.decodeIfPresent(String.self, forKey: .accessToken)
        self.refreshToken = try container.decodeIfPresent(String.self, forKey: .refreshToken)
        self.expireTime = try container.decodeIfPresent(Int.self, forKey: .expireTime)
        self.appId = try container.decodeIfPresent(Int.self, forKey: .appId)
        self.addTime = try container.decodeIfPresent(Int.self, forKey: .addTime)
        self.updateTime = try container.decodeIfPresent(Int.self, forKey: .updateTime)
    }

    static func userInfo() -> TZWUser? {
        let json = UserDefaults.standard.value(forKey: TZWUserInfoKey)
        if json != nil {
            let jsonStr = json as! String
            guard let data = jsonStr.data(using: String.Encoding.utf8) else {
                return nil
            }
            let decoder = JSONDecoder()
            guard let user = try? decoder.decode(TZWUser.self, from: data) else {
                return nil
            }
            return user
        }
        
        return nil
    }
    
    static func isLogin() -> Bool {
        return self.userInfo()?.userId != nil && self.userInfo()?.accessToken != nil
    }
    
    static func loginOut() {
        UserDefaults.standard.removeObject(forKey: TZWUserInfoKey)
    }
}


