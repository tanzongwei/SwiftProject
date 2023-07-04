//
//  TZWUserServer.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/7/4.
//

import Moya

enum TZWUserServer {
    case loginCheckPhone(phone: String?=nil)
}


extension TZWUserServer: TargetType {
    var baseURL: URL {TZWServer.url}
    var sampleData: Data {Data()}
    var headers: [String : String]? { TZWServer.header}
    
    var path: String {
        switch self {
        case .loginCheckPhone: return ""
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .loginCheckPhone(let phone):
            var parameters: [String: Any] = [:]
            var param: [String: Any] = [:]
            param["username"] = phone
            parameters["param"] = param
            let params = TZWServerHandle.getSecret(params: parameters)
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    

    
}
