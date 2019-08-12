//
//  MavPaymentMethodInteractor.swift
//  MavWebPayController
//
//  Created by Mavericks's iOS Dev on 7/30/19.
//  Copyright © 2019 Mavericks. All rights reserved.
//

import Foundation
import RxSwift
import FirebaseAuth

class MavPaymentMethodInteractor: PresenterToInteractorMavPaymentMethodProtocol {
    
    var presenter: InteractorToPresenterMavPaymentMethodProtocol?
    
    func fetchWallet() {
        let firebaseManager = FirebaseManager.shared
        let subscription: PublishSubject<Wallet> = firebaseManager.objectListener(entity: "wallets")
        subscription.subscribe(onNext: { (wallet) in
            self.presenter?.fetchWalletSuccessfull(wallet: wallet)
        }, onError: { (error) in
            self.presenter?.fetchWalletFailure(error: error)
        })
    }
    
    func fetchAuthToken() {
        Auth.auth().currentUser!.getIDTokenResult(forcingRefresh: true, completion: {
            result,error in
            if let token = result?.token{
                MavWebpayConfiguration.shared.token = token
            }
        })
    }
    
    func enrolleCard(wallet: Wallet) {
        WebpayManager.shared.enrolleCard().then({ urlStr in
            let webpay = Webpay()
            if let url = URL(string: urlStr){
                webpay.url = url
            }
            self.presenter?.enrolleCardSuccessfull(webpay: webpay)
        }).catch({
            print($0)
            self.presenter?.enrolleCardFailure(error: $0)
        })
    }
    
    func unsubscribeCard(wallet: Wallet) {
        WebpayManager.shared.unsubscribeEnrollment().then({
            print($0)
            self.presenter?.unsubscribeCardSuccessfull()
        }).catch({
            print($0)
            self.presenter?.unsubscribeCardFailure(error: $0)
        })
    }
}
