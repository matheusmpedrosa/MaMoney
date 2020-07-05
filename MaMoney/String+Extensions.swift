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
        let colorsDictionary: [String: UIColor] = [
            "green": .systemGreen,
            "red": .systemRed,
            "blue": .systemBlue,
            "yellow": .systemYellow,
            "purple": .systemPurple,
            "teal": .systemTeal,
            "orange": .systemOrange,
            "pink": .systemPink,
            "indigo": .systemIndigo,
            "gray": .systemGray
        ]
        
        let color = colorsDictionary.filter { $0.key == self }
        
        return color.first!.value
    }
}
