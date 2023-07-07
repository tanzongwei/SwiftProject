//
//  TZWServer.swift
//  SwiftProject
//
//  Created by tanzongwei on 2023/7/3.
//

import Foundation
import Moya
import PromiseKit

struct TZWServer {
    enum Environment: String {
        case test = "https://tw.circle520.cn/api/v1/"
        case logintTest = "http://member.dev.adnonstop.com.cn/services/"
        case oldTest = "http://tw.circle520.cn/beauty/app/api/camhomme/biz/beta/api/public/index.php"
        case product = "https://open.circle520.cn/api/v1/"
        case oldProduct = "https://open.circle520.cn/camhomme/biz/prod/api/public/index.php"
        var url: URL {URL(string: self.rawValue)!}
    }
    static var environment: Environment = .logintTest
    static var url: URL { environment.url }
    static var header: [String: String] {
        var header: [String: String] = [:]
        header["Content-type"] = "application/json"
        header["User-Agent"] = "camhomme/3.18.1 (iPhone; iOS 15.3; Scale/3.00)"
        header["Accept-Language"] = "zh-Hans-CN;q=1"
        header["X-Accept-Language"] = "zh-CN"

        return header
    }
    
}

struct TZWServerRespond<Payload: Decodable>: Decodable {
    var code: Int
    var msg: String?
    var data: Payload?
    var haspsw: Bool?
    
    enum CodingKeys: CodingKey {
        case code
        case msg
        case data
        case haspsw
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy:CodingKeys.self)
        if let _code = try? container.decode(Int.self, forKey: CodingKeys.code) {
            self.code = _code
        } else if let _code = try? container.decode(String.self, forKey: CodingKeys.code) {
            self.code = Int(_code)!
        } else {
            self.code = -1
        }
        
        if container.contains(.data) {
            self.data = try? container.decode(Payload.self, forKey: CodingKeys.data)
        }

        if container.contains(.msg) {
            self.msg = try container.decode(String.self, forKey: CodingKeys.msg)
        }
        
        if container.contains(.haspsw) {
            self.haspsw = try container.decode(Bool.self, forKey: CodingKeys.haspsw)
        }

    }
}

enum ServerError: Error {
    case invalidData
    case serverError(code: Int, msg: String?)
}


extension MoyaProvider {
    func TZWNetWorkRequest<T: Decodable>(_ target: Target, showHud: Bool = false, showErrorHud: Bool = true, hudText: String?=nil) -> Promise<T?> {
        var hud: MBProgressHUD?
        if showHud {
            hud = MBProgressHUD.init()
            hud?.mode = .indeterminate
            hud?.label.text = hudText
            hud?.show(animated: true)
            UIApplication.shared.keyWindow?.addSubview(hud!)
        }
        
        return Promise { r in
            self.request(target) { result in
                if showHud {
                    hud?.hide(animated: true)
                    hud?.removeAllSubViews()
                }
                switch result {
                case .success(let response):
#if DEBUG
                    if let responseData = String(data: response.data,encoding: .utf8), let url = response.request?.url {
                        print("\(url)")
                        print("\(response.request!.allHTTPHeaderFields!)")
                        print("\(responseData)")
                    }
#endif
                    do {
                        let decoder = JSONDecoder()
                        let serverData = try
                        decoder.decode(TZWServerRespond<T>.self, from: response.data)
                        if serverData.code == 205 ||
                           serverData.code == 216 ||
                           serverData.code == 217 {
                            // 退出登录
                        }
                        guard serverData.code == 200 else {
                            throw ServerError.serverError(code: serverData.code, msg: serverData.msg)
                        }

                        if response.request?.url?.lastPathComponent == "checkMobileExists" {
                            r.fulfill(serverData.data)
                        } else {
                            r.fulfill(serverData.data)
                        }
                    } catch {
                        var alert = error.localizedDescription
                        
                        if case ServerError.serverError(_, let msg) = error {
                            alert = msg ?? error.localizedDescription
                        }
                        
                        r.reject(error)
                    }
                case .failure(let error):
                    if showErrorHud {
                        
                    }
                    r.reject(error)
                }
                
            }
        }
    }
}
