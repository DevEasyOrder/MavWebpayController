//
//  URLsManager.swift
//  MavWebPayController
//
//  Created by Mavericks's iOS Dev on 7/30/19.
//  Copyright © 2019 Mavericks. All rights reserved.
//

import Foundation
import Alamofire
//import Firebase

class URLsManager: NSObject {
    
    //MARK: - Router
    
    enum Router: URLRequestConvertible {
        
        //set request constants
        case initInscription(params: Parameters?)
        case finishInscription(params: Parameters?)
        case authorize(params: Parameters)
        case unsubscribe(params: Parameters?)
        
        //base URL
        
        static var baseURL: String{
            return MavWebpayConfiguration.shared.baseURL
        }
        
        //Method
        var method: HTTPMethod{
            switch self {
            case .initInscription(_):
                return .get
            case .finishInscription(_):
                return .post
            case .authorize(_):
                return .post
            case .unsubscribe(_):
                return .post
            }
        }
        
        //Path
        var path: String{
            
            switch self {
            case .initInscription(_):
                return "initInscription"
            case .finishInscription(_):
                return "finishInscription"
            case .authorize(_):
                return "authorize"
            case .unsubscribe(_):
                return "unsubscribe"
            }
            
        }
        
        //URL Request
        
        func asURLRequest() throws -> URLRequest {
            let url = try Router.baseURL.asURL()
            
            var urlRequest = URLRequest(url: url.appendingPathComponent(path))
            urlRequest.httpMethod = method.rawValue
            
            switch self {
            case .initInscription(let params):
                urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
                urlRequest.setValue("Bearer \(MavWebpayConfiguration.shared.token)", forHTTPHeaderField: "Authorization")
                break
            case .finishInscription(let params):
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.httpMethod = "POST"
                urlRequest.setValue("Bearer \(MavWebpayConfiguration.shared.token)", forHTTPHeaderField: "Authorization")
                break
            case .authorize(let params):
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.httpMethod = "POST"
                
                urlRequest = try URLEncoding.default.encode(urlRequest, with: params)
                urlRequest.setValue("Bearer \(MavWebpayConfiguration.shared.token)", forHTTPHeaderField: "Authorization")
                break
            case .unsubscribe(let params):
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.httpMethod = "POST"
                urlRequest.setValue("Bearer \(MavWebpayConfiguration.shared.token)", forHTTPHeaderField: "Authorization")
                break
            }
            return urlRequest
        }
    }
    
}
