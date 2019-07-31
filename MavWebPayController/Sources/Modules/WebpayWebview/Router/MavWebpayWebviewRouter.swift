//
//  MavWebpayWebviewRouter.swift
//  MavWebPayController
//
//  Created by Mavericks's iOS Dev on 7/31/19.
//  Copyright © 2019 Mavericks. All rights reserved.
//

import Foundation

class MavWebpayWebviewRouter: PresenterToRouterMavWebpayWebviewProtocol {
    
    static func createWebViewModule(webpay: Webpay) -> UINavigationController {
        let vc = MavWebpayWebviewViewController(nibName: String(describing: MavWebpayWebviewViewController.self), bundle: Bundle(for: MavWebpayWebviewViewController.self))
        vc.webpay = webpay
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }
    
    
}
