//
//  UIColor+Extensions.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 09/02/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
    
    class func color(data: Data) -> UIColor? {
         return try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? UIColor
    }

    func encode() -> Data? {
         return try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
    }
}
