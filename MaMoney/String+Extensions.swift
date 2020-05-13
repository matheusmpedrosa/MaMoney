//
//  String+Extension.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 13/05/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func colorFromString() -> UIColor {
        if self == "green" {
            return .systemGreen
        }
        
        if self == "red" {
            return .systemRed
        }
        
        if self == "blue" {
            return .systemBlue
        }
        
        if self == "yellow" {
            return .systemYellow
        }
        
        return .systemIndigo
    }
}
