//
//  MavWebpayWebviewProtocols.swift
//  MavWebPayController
//
//  Created by Mavericks's iOS Dev on 7/31/19.
//  Copyright © 2019 Mavericks. All rights reserved.
//

import Foundation
protocol ViewToPresenterMavWebpayWebviewProtocol:class{
    
    var view: PresenterToViewMavWebpayWebviewProtocol? {get set}
    var interactor: PresenterToInteractorMavWebpayWebviewProtocol? {get set}
    var router: PresenterToRouterMavWebpayWebviewProtocol? {get set}
 
    func handleURL(urlRequest: URLRequest)
}

protocol PresenterToViewMavWebpayWebviewProtocol:class {
    
    func handleURLSuccessfull(message: String)
    func handleURLFailure(message: String)
    
}

protocol PresenterToRouterMavWebpayWebviewProtocol:class {
    static func createWebViewModule(webpay: Webpay)->UINavigationController
}

protocol PresenterToInteractorMavWebpayWebviewProtocol:class {
    
    var presenter:InteractorToPresenterMavWebpayWebviewProtocol? {get set}
    
    func handleURL(urlRequest: URLRequest)
}

protocol InteractorToPresenterMavWebpayWebviewProtocol:class {
    func handleURLSuccessfull(message: String)
    func handleURLFailure(message: String)
}
