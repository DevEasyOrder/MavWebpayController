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
    @IBOutlet open weak var walletStackedLabel: UILabel!
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
    public var enrollTitle: String = "Ingresar Tarjeta"
    public var unrollTitle: String = "Eliminar Tarjeta"
    public var navTitle: String = "Medios de Pago"
    
    public var backButton: UIBarButtonItem?{
        didSet{
            self.navigationItem.setLeftBarButton(backButton, animated: true)
        }
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    public static var bundles: [Bundle] {
        let bundle = Bundle(for: self)
        let paths = bundle.paths(forResourcesOfType: "bundle", inDirectory: nil)
        var someBundles: [Bundle] = []
        for path in paths {
            if let someBundle = Bundle(path: path) {
                someBundles.append(someBundle)
            }
        }
        return someBundles
    }
    
    public static func image(named: String) -> UIImage? {
        // return the first occurrence of an image named 'named' from all existing bundles
        for bundle in bundles {
            if let image = UIImage(named: named, in: bundle, compatibleWith: nil) {
                return image
            }
        }
        return nil
    }


    
    public convenience init(){
        print(MavPaymentMethodsViewController.bundles)
        let bundle = MavPaymentMethodsViewController.bundles.first ?? Bundle(for: MavPaymentMethodsViewController.self)
        print(bundle)
        for bud in MavPaymentMethodsViewController.bundles{
            print(bud.bundlePath)
        }
        self.init(nibName: String(describing: MavPaymentMethodsViewController.self), bundle: Bundle(for: MavPaymentMethodsViewController.self))
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        self.walletContainerView.backgroundColor = .white
        self.walletContainerView.borderAndBottomShadow()
        self.webpayButton.addTarget(self, action: #selector(changeWebpayStatus), for: .touchUpInside)
        self.addCoupon.addTarget(self, action: #selector(addCouponDialog), for: .touchUpInside)
        self.presenter.fetchWallet()
        self.navigationItem.title = self.navTitle
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.fetchAuthToken()
    }
    
    @objc func changeWebpayStatus(){
        self.hud.showDismissableMessage(message: NSLocalizedString("Cargando", comment: ""))
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
        let bundle = MavPaymentMethodsViewController.bundles.first ?? Bundle(for: MavPaymentMethodsViewController.self)
        self.wallet = wallet
        self.amountLabel.text = wallet.balance.currency()
        self.last4DigitsLabel.text = wallet.last4Digits
        self.holderNameLabel.text = wallet.holder
        self.webpayButton.setTitle(wallet.tbkUser != "" ? self.unrollTitle : self.enrollTitle, for: .normal)
        var image = self.bundledImage(named: MavWebpayConfiguration.shared.nullCardName)
//        var image = MavPaymentMethodsViewController.image(named: MavWebpayConfiguration.shared.nullCardName)
        if(wallet.creditCardType == "Visa"){
            image = self.bundledImage(named: "ic_card_visa")
//            image = MavPaymentMethodsViewController.image(named: "ic_card_visa")
            self.cardImageView.image = image
        }else if(wallet.creditCardType == "MasterCard"){
            image = self.bundledImage(named: "ic_card_mastercard")
//            image = MavPaymentMethodsViewController.image(named: "ic_card_mastercard")
            self.cardImageView.image = image
        }else{
            self.cardImageView.image = image
        }
    }
    
    func fetchWalletFailure(error: Error) {
        let colorScheme = MDCSemanticColorScheme()
        MDCSnackbarMessageView.appearance().snackbarMessageViewBackgroundColor = .red
        // Step 3: Apply the color scheme to your component
        MDCSnackbarColorThemer.applySemanticColorScheme(colorScheme)
        let message = MDCSnackbarMessage()
        message.duration = 10.0
        message.text = NSLocalizedString("Ha ocurrido un error en la carga de tu wallet",comment: "")
        MDCSnackbarManager.show(message)
    }
    
    func enrolleCardSuccessfull(webpay: Webpay) {
        self.hud.dismiss()
        let vc = MavWebpayWebviewRouter.createWebViewModule(webpay: webpay)
        self.present(vc, animated: true, completion: nil)
    }
    
    func enrolleCardFailure(error: Error) {
        self.hud.showDismissableError(status: NSLocalizedString("La tarjeta no se ha podido agregar de manera correcta.", comment: ""))
    }
    
    func unsubscribeCardSuccessfull() {
        self.hud.showDismissableSuccess(status: NSLocalizedString("Tarjeta Removida exitosamente", comment: ""))
    }
    
    func unsubscribeCardFailure(error: Error) {
        self.hud.showDismissableError(status: NSLocalizedString("La tarjeta no se ha podido eliminar correctamente", comment: ""))
    }
    
    
    func bundledImage(named: String) -> UIImage? {
        let image = UIImage(named: named)
        if image == nil {
            return UIImage(named: named, in: Bundle(for: MavPaymentMethodsViewController.classForCoder()), compatibleWith: nil)
        } // Replace MyBasePodClass with yours
        return image
    }
    
}

