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
        var vc = MavPaymentMethodsViewController()        
        let presenter: ViewToPresenterMavPaymentMethodProtocol & InteractorToPresenterMavPaymentMethodProtocol = MavPaymentMethodPresenter()
        let interactor: PresenterToInteractorMavPaymentMethodProtocol = MavPaymentMethodInteractor()
        let router:PresenterToRouterMavPaymentMethodProtocol = MavPaymentMethodsRouter()
        presenter.view = vc
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        vc.presenter = presenter as! MavPaymentMethodPresenter
        vc = presenter.view as! MavPaymentMethodsViewController
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }
    
}
