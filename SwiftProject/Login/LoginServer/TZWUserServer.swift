//
//  TZWUserServer.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/7/4.
//

import Moya

enum TZWUserServer {
    case loginCheckPhone(phone: String?=nil,zoneNum: String?=nil)
    case pwdLogin(phone: String?=nil,zoneNum: String?=nil,pwd: String?=nil)
    case test
}


extension TZWUserServer: TargetType {
    var baseURL: URL {TZWServer.url}
    var sampleData: Data {Data()}
    var headers: [String : String]? { TZWServer.header}
    
    var path: String {
        switch self {
        case .loginCheckPhone: return "member/product/checkMobileExists"
        case .pwdLogin: return "member/product/doLoginByPhoneEncryption"
        case .test: return "member/product/doLoginByPhoneEncryption"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .test:
            return .get
        default:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .loginCheckPhone(let phone,let zoneNum):
            var parameters: [String: Any] = [:]
            var param: [String: Any] = [:]
            let phoneString: NSString = NSString(string: phone!)
            param["username"] = phoneString.ba_aes128()
            param["zoneNum"] = TZWLoginNumberCheckTool.createAreaCode(zoneNum)
            parameters = getParames(parame: param)
            let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
            return .requestData(jsonData)
        case .pwdLogin(let phone, let zoneNum, let pwd):
            var param: [String: Any] = [:]
            let phoneString: NSString = NSString(string: phone!)
            param["phone"] = phoneString.ba_aes128()
            param["password"] = NSString(string: pwd!).ba_md5()
            param["zoneNum"] = TZWLoginNumberCheckTool.createAreaCode(zoneNum)
            let jsonData = try! JSONSerialization.data(withJSONObject: getParames(parame: param), options: [])
            return .requestData(jsonData)

        case .test:
            var parameters: [String: Any] = [:]
            var param: [String: Any] = [:]
            param["username"] = "test"
            param["zoneNum"] = "86"
            parameters = getParames(parame: param)
            let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
            return .requestData(jsonData)
        }
    }
    

    private func getParames(parame: [String: Any]) -> [String: Any] {
        let parameters: [String: Any] = [:]
        var params: [String: Any] = [:]
        let dict: NSDictionary = NSDictionary(dictionary: TZWServerHandle.getSecret(params: parameters))
        
        let paramDict = dict.ba_addSign(withParams: parame)!
        
        for(key,var value) in paramDict {
            if let stringKey = key.base as? String {
                if stringKey == "param" {
                    value = paramTransform(parame: value as! [AnyHashable : Any])
                }
                params[stringKey] = value
            }
        }
        
        return params
    }
    
    private func paramTransform(parame: [AnyHashable: Any]) -> [String: Any] {
        var parameters: [String: Any] = [:]

        for(key,value) in parame {
            if let stringKey = key.base as? String {
                parameters[stringKey] = value
            }
        }

        return parameters
    }
    
    func convertToJsonString(dictionary: [String: Any]) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary,options: [])
            let jsonString = String(data: jsonData, encoding: .utf8)
            return jsonString
        } catch {
            return nil
        }
    }
    
    
    static func isLogin(isLogin: Bool) -> Bool {
        return isLogin
    }
    
    static func saveUserInfo(userInfo: TZWUser) {
        let jsonEncode = JSONEncoder()
        var jsonData = Data()
        
        do {
            jsonData = try jsonEncode.encode(userInfo)
        } catch  {
        }
        _ = String(data: jsonData, encoding: .utf8)
        
    }
    
    static func saveUser(json: String?) {
        if json == nil {
            return
        }
        UserDefaults.standard.setValue(json, forKey: TZWUserInfoKey)
    }
}
