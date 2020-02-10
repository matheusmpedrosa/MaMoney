//
//  SheetItem.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 09/02/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import Foundation

struct SheetItem {
    var title: String = ""
    var isInstalment: Bool? = false
    var instalments: Int? = 0
    var paymentStatus: PaymentStatus? = .notPayed
    var value: Decimal = 0.0
    
    func getMoneyInItemsMock() -> [SheetItem] {
        var mock: [SheetItem] = []
        mock.append(SheetItem(title: "Salário", value: 5500.00))
        return mock
    }
    
    func getMoneyOutItemsMock() -> [SheetItem] {
        var mock: [SheetItem] = []
        mock.append(SheetItem(title: "Cartão de crédito", paymentStatus: .notPayed, value: 500.00))
        mock.append(SheetItem(title: "Aluguel", paymentStatus: .notPayed, value: 650.00))
        return mock
    }
    
    func getRegularExpensesItemsMock() -> [SheetItem] {
        var mock: [SheetItem] = []
        mock.append(SheetItem(title: "Televisão", isInstalment: true, instalments: 5, paymentStatus: .notPayed, value: 5289.80))
        mock.append(SheetItem(title: "Roupas", isInstalment: true, instalments: 2, paymentStatus: .notPayed, value: 90.50))
        mock.append(SheetItem(title: "Viagem", isInstalment: true, instalments: 10, paymentStatus: .notPayed, value: 10023.90))
        mock.append(SheetItem(title: "Academia", isInstalment: false, paymentStatus: .notPayed, value: 99.90))
        return mock
    }
}
