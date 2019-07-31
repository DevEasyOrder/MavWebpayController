//
//  MavWebpayWebviewInteractor.swift
//  MavWebPayController
//
//  Created by Mavericks's iOS Dev on 7/31/19.
//  Copyright © 2019 Mavericks. All rights reserved.
//

import Foundation

class MavWebpayWebviewInteractor: PresenterToInteractorMavWebpayWebviewProtocol {
    
    var presenter: InteractorToPresenterMavWebpayWebviewProtocol?
    
    func handleURL(urlRequest: URLRequest) {
        if let URL = urlRequest.url{
            if(URL.absoluteString.contains("/finishInscription")){
                WebpayManager.shared.finishEnrollement().then({
                    print($0)
                    self.presenter?.handleURLSuccessfull(message: "Tarjeta agregada exitosamente")
                }).catch({
                    print($0)
                    self.presenter?.handleURLFailure(message: "Ha ocurrido un error inesperado")
                })
                
            }else if(URL.absoluteString.contains("add-fail.php")){
                self.presenter?.handleURLFailure(message: "No se ha podido agregar la tarjeta")
            }else if(URL.absoluteString.contains("remove-fail.php")){
                self.presenter?.handleURLFailure(message: "No se ha podido remover la tarjeta")
            }else if(URL.absoluteString.contains("remove-success.php")){
                self.presenter?.handleURLSuccessfull(message: "Tarjeta removida exitosamente")
            }
        }
    }
}
