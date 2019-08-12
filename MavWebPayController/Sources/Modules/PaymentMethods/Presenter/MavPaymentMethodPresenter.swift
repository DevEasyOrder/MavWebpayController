//
//  MavPaymentMethodPresenter.swift
//  MavWebPayController
//
//  Created by Mavericks's iOS Dev on 7/30/19.
//  Copyright © 2019 Mavericks. All rights reserved.
//

import Foundation

open class MavPaymentMethodPresenter: ViewToPresenterMavPaymentMethodProtocol {
    
    var view: PresenterToViewMavPaymentMethodProtocol?
    var interactor: PresenterToInteractorMavPaymentMethodProtocol?
    var router: PresenterToRouterMavPaymentMethodProtocol?
    
    func fetchWallet() {
        interactor?.fetchWallet()
    }
    
    func fetchAuthToken() {
        interactor?.fetchAuthToken()
    }
    
    func changeCardStatus(wallet: Wallet) {
        if(wallet.tbkUser != ""){
            self.interactor?.unsubscribeCard(wallet: wallet)
            return
        }
        self.interactor?.enrolleCard(wallet: wallet)
    }
}

extension MavPaymentMethodPresenter: InteractorToPresenterMavPaymentMethodProtocol{
    
    func fetchWalletSuccessfull(wallet: Wallet) {
        view?.fetchWalletSuccessfull(wallet: wallet)
    }
    
    func fetchWalletFailure(error: Error) {
        view?.fetchWalletFailure(error: error)
    }
    
    func enrolleCardSuccessfull(webpay: Webpay) {
        view?.enrolleCardSuccessfull(webpay: webpay)
    }
    
    func unsubscribeCardSuccessfull() {
        view?.unsubscribeCardSuccessfull()
    }
    
    func enrolleCardFailure(error: Error) {
        view?.enrolleCardFailure(error: error)
    }
    
    func unsubscribeCardFailure(error: Error) {
        view?.unsubscribeCardFailure(error: error)
    }
}
