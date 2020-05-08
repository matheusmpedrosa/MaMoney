//
//  UITextField+Extensions.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 01/05/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import UIKit

extension UITextField {
    func getDecimalValue() -> Decimal {
        guard let text = self.text else { return 0 }
        let centsNumber = text.compactMap { char in
            return Double(char.description)
            }.reduce(0, {($0 * 10) + $1})
        let number: Decimal = Decimal(centsNumber) / 100
        return number
    }
    
    public func formatTextToCurrency() {
        self.text = getDecimalValue().toBrazilianRealString()
    }
}
