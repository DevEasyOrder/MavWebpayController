//
//  Wallet.swift
//  MavWebPayController
//
//  Created by Mavericks's iOS Dev on 7/30/19.
//  Copyright © 2019 Mavericks. All rights reserved.
//

import Foundation
import ObjectMapper

open class Wallet: Mappable {
    
    open var balance: Int = 0
    open var last4Digits: String = ""
    open var holder: String = ""
    open var creditCardType: String = ""
    open var tbkUser: String = ""
    open var token: String = ""
    
    public convenience required init?(map: Map) {
        self.init()
    }
    
    public func mapping(map: Map) {
        balance<-map["balance"]
        last4Digits<-map["last4Digits"]
        holder<-map["holder"]
        creditCardType<-map["creditCardType"]
        tbkUser<-map["tbkUser"]
        token<-map["token"]
    }
    
}
