//
//  ViewExtensions.swift
//  MavWebPayController
//
//  Created by Mavericks's iOS Dev on 7/31/19.
//  Copyright © 2019 Mavericks. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func borderAndBottomShadow(){
        self.layer.cornerRadius = 4.0
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.5
    }
}
