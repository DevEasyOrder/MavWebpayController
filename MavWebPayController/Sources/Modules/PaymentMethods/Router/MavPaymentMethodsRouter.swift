//
//  MavPaymentMethodsRouter.swift
//  MavWebPayController
//
//  Created by Mavericks's iOS Dev on 7/30/19.
//  Copyright © 2019 Mavericks. All rights reserved.
//

import Foundation

open class MavPaymentMethodsRouter: PresenterToRouterMavPaymentMethodProtocol {
    
    public static func createPaymentModule() -> UINavigationController {
        let vc = MavPaymentMethodsViewController(nibName: String(describing: MavPaymentMethodsViewController.self), bundle: Bundle(for: MavPaymentMethodsViewController.self))
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }
    
}
