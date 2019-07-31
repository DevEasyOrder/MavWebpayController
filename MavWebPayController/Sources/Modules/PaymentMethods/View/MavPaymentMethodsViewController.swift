//
//  MavPaymentMethodsViewController.swift
//  MavWebPayController
//
//  Created by Mavericks's iOS Dev on 7/30/19.
//  Copyright © 2019 Mavericks. All rights reserved.
//

import UIKit
import SVDismissableProgressHUD
import MaterialComponents.MaterialSnackbar
import MaterialComponents.MaterialSnackbar_ColorThemer

public protocol MAVPaymentMethodsViewControllerDelegate: class{
    func willAddCoupon()
}

open class MavPaymentMethodsViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet open weak var webpayButton: UIButton!
    @IBOutlet open weak var addCoupon: FormButton!
    @IBOutlet open weak var amountLabel: UILabel!
    @IBOutlet open weak var walletContainerView: UIView!
    @IBOutlet open weak var last4DigitsLabel: UILabel!
    @IBOutlet open weak var holderNameLabel: UILabel!
    @IBOutlet open weak var cardImageView: UIImageView!
    
    //MARK: - Variables
    open weak var delegate: MAVPaymentMethodsViewControllerDelegate? = nil
    open var presenter: MavPaymentMethodPresenter = MavPaymentMethodPresenter()
    private var hud: SVDismissableProgressHUD = SVDismissableProgressHUD()
    var wallet: Wallet = Wallet()
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        self.walletContainerView.backgroundColor = .white
        self.walletContainerView.borderAndBottomShadow()
        self.webpayButton.addTarget(self, action: #selector(changeWebpayStatus), for: .touchUpInside)
        self.addCoupon.addTarget(self, action: #selector(addCouponDialog), for: .touchUpInside)
        self.presenter.fetchWallet()
        self.navigationItem.title = "Medios de Pago"
        self.tabBarItem.image = UIImage(named: "ic_payment")
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.fetchAuthToken()
    }
    
    @objc func changeWebpayStatus(){
        self.presenter.changeCardStatus(wallet: self.wallet)
    }
    
    
    @objc func addCouponDialog(){
        if let delegate = self.delegate{
            delegate.willAddCoupon()
        }
    }

}

extension MavPaymentMethodsViewController: PresenterToViewMavPaymentMethodProtocol{
    func fetchWalletSuccessfull(wallet: Wallet) {
        self.wallet = wallet
        self.amountLabel.text = wallet.balance.currency()
        self.last4DigitsLabel.text = wallet.last4Digits
        self.holderNameLabel.text = wallet.holder
        self.webpayButton.setTitle(wallet.tbkUser != "" ? "Eliminar Tarjeta" : "Ingresar Tarjeta", for: .normal)
        if(wallet.creditCardType == "Visa"){
            self.cardImageView.image = UIImage(named: "ic_card_visa")
        }else if(wallet.creditCardType == "Mastercard"){
            self.cardImageView.image = UIImage(named: "ic_card_mastercard")
        }else{
            self.cardImageView.image = UIImage(named: "ic_card_blank")
        }
    }
    
    func fetchWalletFailure(error: Error) {
        let colorScheme = MDCSemanticColorScheme()
        MDCSnackbarMessageView.appearance().snackbarMessageViewBackgroundColor = .red
        // Step 3: Apply the color scheme to your component
        MDCSnackbarColorThemer.applySemanticColorScheme(colorScheme)
        let message = MDCSnackbarMessage()
        message.duration = 10.0
        message.text = "Ha ocurrido un error en la carga de tu wallet"
        MDCSnackbarManager.show(message)
    }
    
    func enrolleCardSuccessfull() {
        self.hud.showDismissableSuccess(status: "Tarjeta agregada exitosamente")
    }
    
    func enrolleCardFailure(error: Error) {
        self.hud.showDismissableError(status: "La tarjeta no se ha podido agregar de manera correcta.")
    }
    
    func unsubscribeCardSuccessfull() {
        self.hud.showDismissableSuccess(status: "Tarjeta Removida exitosamente")
    }
    
    func unsubscribeCardFailure(error: Error) {
        self.hud.showDismissableError(status: "La tarjeta no se ha podido eliminar correctamente")
    }
}
