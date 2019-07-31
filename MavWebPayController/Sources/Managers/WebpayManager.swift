//
//  WebpayManager.swift
//  MavWebPayController
//
//  Created by Mavericks's iOS Dev on 7/30/19.
//  Copyright © 2019 Mavericks. All rights reserved.
//

import Foundation
import Alamofire
import Promise

public class WebpayManager {
    
    //MARK: - Singleton
    static let shared: WebpayManager = WebpayManager()
    private init () {}
    
    //MARK: - Enrolle Card
    public func enrolleCard()->Promise<String>{
        return Promise<String>(work: {
            fulfill,reject in
            Alamofire.request(URLsManager.Router.initInscription(params: nil)).responseJSON(completionHandler: {
                response in
                
                guard response.result.error == nil else{
                    reject(response.result.error!)
                    return
                }
                
                print(response.result.value)
                if let dict = response.result.value as? [String : Any]{
                    if let url = dict["data"] as? String{
                        fulfill(url)
                        return
                    }
                }
            })
        })
    }
    
    //MARK: - Finish Enrollement
    public func finishEnrollement()->Promise<[String : Any]>{
        return Promise<[String : Any]>(work: {
            fulfill,reject in
            Alamofire.request(URLsManager.Router.finishInscription(params: nil)).responseJSON(completionHandler: {
                response in
                
                guard response.result.error == nil else{
                    reject(response.result.error!)
                    return
                }
                
                if let dict = response.result.value as? [String : Any]{
                    if let url = dict["data"] as? [String : Any]{
                        let code = url["responseCode"] as? Int ?? 0
                        guard code == 0 else{
                            reject(NSError(domain: "MAVWebpay", code: 400, userInfo: [NSLocalizedDescriptionKey : "Error en la transacción"]))
                            return
                        }
                        fulfill(url)
                        return
                    }
                }
                reject(NSError(domain: "Weemo", code: 400, userInfo: nil))
            })
        })
    }
    
    //MARK: - Unsubscribe enrollement
    public func unsubscribeEnrollment()->Promise<Bool>{
        return Promise<Bool>(work: {
            fulfill, reject in
            Alamofire.request(URLsManager.Router.unsubscribe(params: nil)).responseJSON(completionHandler: {
                response in
                guard response.result.error == nil else{
                    reject(response.result.error!)
                    return
                }
                
                if let dict = response.result.value as? [String : Any]{
                    if let url = dict["data"] as? Bool{
                        fulfill(url)
                        return
                    }
                }
                reject(NSError(domain: "MAVWebpay", code: 400, userInfo: nil))
            })
        })
    }
    
    //MARK: - Authorize
    public func authorize()->Promise<[String : Any]>{
        return Promise<[String : Any]>(work: {
            fulfill, reject in
           
            var queryParams = ""
            for key in MavWebpayConfiguration.shared.authorizationParams.keys{
                queryParams = queryParams.appending("\(key)=\(String(describing: MavWebpayConfiguration.shared.authorizationParams[key]))&")
            }
            queryParams = String(queryParams.dropLast())
            Alamofire.request("\(MavWebpayConfiguration.shared.baseURL)/authorize?\(queryParams)", method: .post, parameters: nil, headers: [
                "Authorization" : "Bearer \(MavWebpayConfiguration.shared.token)"
                ]).responseJSON(completionHandler: {
                    response in
                    guard response.result.error == nil else{
                        reject(response.result.error!)
                        return
                    }
                    
                    if let dict = response.result.value as? [String : Any]{
                        if let url = dict["data"] as? [String : Any]{
                            fulfill(url)
                            return
                        }
                    }
                    reject(NSError(domain: "MAVWebpay", code: 400, userInfo: nil))
                })
        })
    }
    
}
