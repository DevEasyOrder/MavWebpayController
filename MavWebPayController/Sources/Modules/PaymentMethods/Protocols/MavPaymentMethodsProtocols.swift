//
//  MavPaymentMethodsProtocols.swift
//  MavWebPayController
//
//  Created by Mavericks's iOS Dev on 7/30/19.
//  Copyright © 2019 Mavericks. All rights reserved.
//

import Foundation
protocol ViewToPresenterMavPaymentMethodProtocol:class{
    
    var view: PresenterToViewMavPaymentMethodProtocol? {get set}
    var interactor: PresenterToInteractorMavPaymentMethodProtocol? {get set}
    var router: PresenterToRouterMavPaymentMethodProtocol? {get set}
    
    func fetchWallet()
    func fetchAuthToken()
    func changeCardStatus(wallet: Wallet)
    
}

protocol PresenterToViewMavPaymentMethodProtocol:class {
    func fetchWalletSuccessfull(wallet: Wallet)
    func fetchWalletFailure(error: Error)
    func enrolleCardSuccessfull(webpay: Webpay)
    func unsubscribeCardSuccessfull()
    func enrolleCardFailure(error: Error)
    func unsubscribeCardFailure(error: Error)
}

protocol PresenterToRouterMavPaymentMethodProtocol:class {
    static func createPaymentModule()->UINavigationController
}

protocol PresenterToInteractorMavPaymentMethodProtocol:class {
    
    var presenter:InteractorToPresenterMavPaymentMethodProtocol? {get set}
    func fetchWallet()
    func fetchAuthToken()
    func enrolleCard(wallet: Wallet)
    func unsubscribeCard(wallet: Wallet)
}

protocol InteractorToPresenterMavPaymentMethodProtocol:class {
    func fetchWalletSuccessfull(wallet: Wallet)
    func fetchWalletFailure(error: Error)
    func enrolleCardSuccessfull(webpay: Webpay)
    func unsubscribeCardSuccessfull()
    func enrolleCardFailure(error: Error)
    func unsubscribeCardFailure(error: Error)
}
