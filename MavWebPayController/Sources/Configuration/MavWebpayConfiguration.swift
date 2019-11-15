//
//  MavWebpayConfiguration.swift
//  MavWebPayController
//
//  Created by Mavericks's iOS Dev on 7/30/19.
//  Copyright © 2019 Mavericks. All rights reserved.
//

import Foundation

open class MavWebpayConfiguration{
    
    //MARK: - Singleton
    public static let shared: MavWebpayConfiguration = MavWebpayConfiguration()
    private init() {}
    
    open var baseURL: String = "localhost"
    open var authorizationParams: [String : Any] = [:]
    open var token: String = ""
    open var barTintColor: UIColor = .red
    open var nullCardName: String = "ic_card_blank"
    
    
}
