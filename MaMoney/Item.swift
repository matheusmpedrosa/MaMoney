//
//  SheetItem.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 09/02/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import Foundation

struct Item {
    var title: String = ""
    var isInstalment: Bool? = false
    var instalments: Int? = 0
    var paymentStatus: PaymentStatus? = .notPayed
    var value: Decimal = 0.0
    var date: Date = Date()
    
    func getMoneyInItemsMock() -> [Item] {
        var mock: [Item] = []
        mock.append(Item(title: "Salário", value: 5500.00))
        return mock
    }
    
    func getMoneyOutItemsMock() -> [Item] {
        var mock: [Item] = []
        mock.append(Item(title: "Cartão de crédito", paymentStatus: .notPayed, value: 500.00))
        mock.append(Item(title: "Aluguel", paymentStatus: .notPayed, value: 650.00))
        return mock
    }
    
    func getRegularExpensesItemsMock() -> [Item] {
        var mock: [Item] = []
        mock.append(Item(title: "Televisão", isInstalment: true, instalments: 5, paymentStatus: .notPayed, value: 5289.80))
        mock.append(Item(title: "Roupas", isInstalment: true, instalments: 2, paymentStatus: .notPayed, value: 90.50))
        mock.append(Item(title: "Viagem", isInstalment: true, instalments: 10, paymentStatus: .notPayed, value: 10023.90))
        mock.append(Item(title: "Academia", isInstalment: false, paymentStatus: .notPayed, value: 99.90))
        return mock
    }
}
