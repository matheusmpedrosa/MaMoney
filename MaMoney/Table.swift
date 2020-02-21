//
//  Sheet.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 09/02/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import Foundation
import UIKit

struct Table {
    var title: String = ""
    var type: TableType = .regularExpenses
    var color: UIColor = .white
    var items: [Item] = []
    var totalAmount: Decimal? = 0.0
    
    func getMoneyInTableMock() -> Table {
        let items: [Item] = Item().getMoneyInItemsMock()
        let amount: Decimal = {
            var decimal: Decimal = 0.0
            for item in items {
                decimal = decimal + item.value
            }
            return decimal
        }()
        let mock: Table = Table(title: "Money In", type: .moneyIn, color: .systemGreen, items: items, totalAmount: amount)
        return mock
    }
    
    func getMoneyOutTableMock() -> Table {
        let items: [Item] = Item().getMoneyOutItemsMock()
        let amount: Decimal = {
            var decimal: Decimal = 0.0
            for item in items {
                decimal = decimal + item.value
            }
            return decimal
        }()
        let mock: Table = Table(title: "Money Out", type: .moneyOut, color: .systemRed, items: items, totalAmount: amount)
        return mock
    }
    
    func getLeftOverTableMock() -> Table {
        let moneyIn = getMoneyInTableMock()
        let moneyOut = getMoneyOutTableMock()
        let totalAmount: Decimal = (moneyIn.totalAmount ?? 0.0) - (moneyOut.totalAmount ?? 0.0)
        let leftOver: Item = Item(title: "Income minus expenses", value: totalAmount)
        let mock: Table = Table(title: "Left Over", type: .leftOver, color: .systemTeal, items: [leftOver], totalAmount: totalAmount)
        return mock
    }
    
    func getRegularExpensesTableMock() -> Table {
        let items: [Item] = Item().getRegularExpensesItemsMock()
        let amount: Decimal = {
            var decimal: Decimal = 0.0
            for item in items {
                decimal += item.value
            }
            return decimal
        }()
        let mock: Table = Table(title: "Regular Expenses", type: .regularExpenses, color: .systemYellow, items: items, totalAmount: amount)
        return mock
    }
}
