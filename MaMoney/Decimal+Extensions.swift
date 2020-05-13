//
//  Decimal+Extensions.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 09/02/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import Foundation

extension Decimal {
    func toBrazilianRealString() -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.numberStyle = .currency
        let string = formatter.string(for: self)
        return string
    }
}

extension NSDecimalNumber {
    func toBrazilianRealString() -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.numberStyle = .currency
        let string = formatter.string(for: self)
        return string
    }
}
