//
//  MavWebpayWebviewPresenter.swift
//  MavWebPayController
//
//  Created by Mavericks's iOS Dev on 7/31/19.
//  Copyright © 2019 Mavericks. All rights reserved.
//

import Foundation

class MavWebpayWebviewPresenter: ViewToPresenterMavWebpayWebviewProtocol {
    
    var view: PresenterToViewMavWebpayWebviewProtocol?
    var interactor: PresenterToInteractorMavWebpayWebviewProtocol?
    var router: PresenterToRouterMavWebpayWebviewProtocol?
    
    func handleURL(urlRequest: URLRequest) {
        interactor?.handleURL(urlRequest: urlRequest)
    }
    
    
}

extension MavWebpayWebviewPresenter: InteractorToPresenterMavWebpayWebviewProtocol{
    
    func handleURLSuccessfull(message: String) {
        view?.handleURLSuccessfull(message: message)
    }
    
    func handleURLFailure(message: String) {
        view?.handleURLFailure(message: message)
    }
}
