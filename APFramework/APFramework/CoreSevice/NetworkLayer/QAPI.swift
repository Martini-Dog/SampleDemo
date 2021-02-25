//
//  QAPI.swift
//  APFramework
//
//  Created by Apple on 2018/2/24.
//  Copyright © 2018年 The_X. All rights reserved.
//

import Moya
import Alamofire

let host = "https://"

enum QApi {
    case login
}

extension QApi: TargetType {
    
    var baseURL: URL { return URL(string: host)! }
    
    var path: String {
        switch self {
        case .login: return ""
            
        }
    }
    
    var task: Task {
        switch self {
        case .login: return .requestParameters(parameters: [:], encoding: URLEncoding.default)
            
//        default: return .requestPlain
        }
    }
    
    var method: Alamofire.HTTPMethod { return .post }
    
    var sampleData: Data { return "{}".data(using: .utf8)! }
    var headers: [String : String]? { return nil }
}
