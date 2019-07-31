//
//  NumberExtension.swift
//  MavWebPayController
//
//  Created by Mavericks's iOS Dev on 7/31/19.
//  Copyright © 2019 Mavericks. All rights reserved.
//

import Foundation
extension Int{
    func currency()->String{
        var str = ""
        let formatter = NumberFormatter()
        formatter.currencySymbol = "$"
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        if let formattedTipAmount = formatter.string(from: self as NSNumber) {
            str = formattedTipAmount.replacingOccurrences(of: ",", with: ".")
        }
        return str
    }
}
