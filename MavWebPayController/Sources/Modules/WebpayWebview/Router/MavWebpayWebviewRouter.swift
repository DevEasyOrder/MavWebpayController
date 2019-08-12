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
        var vc = MavWebpayWebviewViewController(nibName: String(describing: MavWebpayWebviewViewController.self), bundle: Bundle(for: MavWebpayWebviewViewController.self))
        let presenter: ViewToPresenterMavWebpayWebviewProtocol & InteractorToPresenterMavWebpayWebviewProtocol = MavWebpayWebviewPresenter()
        let interactor: PresenterToInteractorMavWebpayWebviewProtocol = MavWebpayWebviewInteractor()
        let router:PresenterToRouterMavWebpayWebviewProtocol = MavWebpayWebviewRouter()
        presenter.view = vc
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        vc.presenter = presenter as! MavWebpayWebviewPresenter
        vc = presenter.view as! MavWebpayWebviewViewController
        vc.webpay = webpay
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }
    
    
}
