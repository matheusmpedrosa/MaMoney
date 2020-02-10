//
//  Sheet.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 09/02/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import Foundation
import UIKit

struct Sheet {
    var title: String = ""
    var type: SheetType = .regularExpenses
    var color: UIColor = .white
    var items: [SheetItem] = []
    var totalAmount: Decimal? = 0.0
    
    func getMoneyInSheetMock() -> Sheet {
        let sheetItems: [SheetItem] = SheetItem().getMoneyInItemsMock()
        let amount: Decimal = {
            var decimal: Decimal = 0.0
            for i in sheetItems {
                decimal = decimal + i.value
            }
            return decimal
        }()
        let mock: Sheet = Sheet(title: "Money In", type: .moneyIn, color: .systemGreen, items: sheetItems, totalAmount: amount)
        return mock
    }
    
    func getMoneyOutSheetMock() -> Sheet {
        let sheetItems: [SheetItem] = SheetItem().getMoneyOutItemsMock()
        let amount: Decimal = {
            var decimal: Decimal = 0.0
            for i in sheetItems {
                decimal = decimal + i.value
            }
            return decimal
        }()
        let mock: Sheet = Sheet(title: "Money Out", type: .moneyOut, color: .systemOrange, items: sheetItems, totalAmount: amount)
        return mock
    }
    
    func getLeftOverSheetMock() -> Sheet {
        let moneyIn = getMoneyInSheetMock()
        let moneyOut = getMoneyOutSheetMock()
        let totalAmount: Decimal = (moneyIn.totalAmount ?? 0.0) - (moneyOut.totalAmount ?? 0.0)
        let leftOver: SheetItem = SheetItem(title: "Income minus expenses", value: totalAmount)
        let mock: Sheet = Sheet(title: "Left Over", type: .leftOver, color: .systemTeal, items: [leftOver], totalAmount: totalAmount)
        return mock
    }
    
    func getRegularExpensesSheetMock() -> Sheet {
        let sheetItems: [SheetItem] = SheetItem().getRegularExpensesItemsMock()
        let amount: Decimal = {
            var decimal: Decimal = 0.0
            for i in sheetItems {
                decimal += i.value
            }
            return decimal
        }()
        let mock: Sheet = Sheet(title: "Regular Expenses", type: .regularExpenses, color: .systemYellow, items: sheetItems, totalAmount: amount)
        return mock
    }
}
