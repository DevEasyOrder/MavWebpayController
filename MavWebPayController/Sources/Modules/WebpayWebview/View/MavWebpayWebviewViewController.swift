//
//  MavWebpayWebviewViewController.swift
//  MavWebPayController
//
//  Created by Mavericks's iOS Dev on 7/31/19.
//  Copyright © 2019 Mavericks. All rights reserved.
//

import UIKit
import SVDismissableProgressHUD

class MavWebpayWebviewViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webview: UIWebView!
    
    //MARK: - Variables
    var presenter: MavWebpayWebviewPresenter = MavWebpayWebviewPresenter()
    var webpay: Webpay = Webpay()
    open var barButton = UIBarButtonItem(title: "✕", style: .plain, target: self, action: #selector(close))
    var hud: SVDismissableProgressHUD = SVDismissableProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = webpay.url{
            self.webview.loadRequest(URLRequest(url: url))
        }
        self.webview.delegate = self
        self.barButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 25.0)], for: .normal)
        self.navigationItem.title = "Webpay"
        self.navigationController?.navigationBar.barTintColor = MavWebpayConfiguration.shared.barTintColor
        self.navigationItem.setLeftBarButton(barButton, animated: true)
        // Do any additional setup after loading the view.
    }
    
    @objc func close(){
        self.dismiss(animated: true, completion: nil)
    }
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        self.presenter.handleURL(urlRequest: request)
        return true
    }
}

extension MavWebpayWebviewViewController: PresenterToViewMavWebpayWebviewProtocol{
    
    func handleURLSuccessfull(message: String) {
        self.hud.showDismissableSuccess(status: message)
        self.dismiss(animated: true, completion: nil)
    }
    
    func handleURLFailure(message: String) {
        self.hud.showDismissableError(status: message)
        self.dismiss(animated: true, completion: nil)
    }
    
}
