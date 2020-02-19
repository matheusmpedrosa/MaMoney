//
//  UIDevice+Extensions.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 09/02/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import Foundation
import UIKit

extension UIDevice {
    var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            let key = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            if UIDevice.current.orientation.isPortrait && (key?.safeAreaInsets.top ?? 0) >= 44 {
                return true
            }
        }
        return false
    }
}
