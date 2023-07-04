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
        case oldTest = "http://tw.circle520.cn/beauty/app/api/camhomme/biz/beta/api/public/index.php"
        case product = "https://open.circle520.cn/api/v1/"
        case oldProduct = "https://open.circle520.cn/camhomme/biz/prod/api/public/index.php"
        var url: URL {URL(string: self.rawValue)!}
    }
    static var environment: Environment = .test
    static var url: URL { environment.url }
    static var header: [String: String] {
        var header: [String: String] = [:]
        header["Content-type"] = "application/json; charset=utf-8"
        return header
    }
    
}

struct TZWServerRespond<Payload: Decodable>: Decodable {
    var resultCode: Int
    var resultMsg: String?
    var data: Payload?
    var currentTime: TimeInterval?
    
    enum CodingKeys: CodingKey {
        case resultCode
        case resultMsg
        case data
        case currentTime
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy:CodingKeys.self)
        if let _resultCode = try? container.decode(Int.self, forKey: CodingKeys.resultCode) {
            self.resultCode = _resultCode
        } else if let _resultCode = try? container.decode(String.self, forKey: CodingKeys.resultCode) {
            self.resultCode = Int(_resultCode)!
        } else {
            self.resultCode = -1
        }
        if container.contains(.currentTime) {
            self.currentTime = try container.decode(TimeInterval.self, forKey: CodingKeys.currentTime)

        }
        
        if container.contains(.data) {
            self.data = try container.decode(Payload.self, forKey: CodingKeys.data)
        }

        if container.contains(.resultMsg) {
            self.resultMsg = try container.decode(String.self, forKey: CodingKeys.resultMsg)

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
                        if serverData.resultCode == 1000102 {
                            // 退出登录
                        }
                        guard serverData.resultCode == 1 else {
                            throw ServerError.serverError(code: serverData.resultCode, msg: serverData.resultMsg)
                        }
                        
                        r.fulfill(serverData.data)
                    } catch {
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
