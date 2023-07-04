//
//  TZWServer.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/7/3.
//

import Foundation
import Moya

struct TZWServer {
    enum Environment: String {
        case test = "https://tw.circle520.cn/api/v1/"
        case oldTest = "http://tw.circle520.cn/beauty/app/api/camhomme/biz/beta/api/public/index.php"
        case product = "https://open.circle520.cn/api/v1/"
        case oldProduct = "https://open.circle520.cn/camhomme/biz/prod/api/public/index.php"
        var url: URL {URL(string: self.rawValue)!}
    }
}


extension MoyaProvider {
    
}
