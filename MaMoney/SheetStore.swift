//
//  SheetStore.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 13/05/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import Foundation
import CoreData

class SheetDataManager {
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchAll(completion: @escaping ([Sheet]?) -> Void) {
        Sheet.fetchSheets(from: context) { (result) in
            if let result = result {
                completion(result)
            } else {
                completion(nil)
            }
        }
    }
    
    func insert() {
        let newSheet = Sheet(context: context)
        newSheet.title = "Nova planilha"
        newSheet.date = Date()
        newSheet.table = NSSet.init(array: [])
        
        Sheet.insertSheet(from: context)
    }
    
    func insertSampleSheet() {
        //expense table
        let sampleExpenseItem1 = Item(context: context)
        sampleExpenseItem1.title = "Mesa de jantar"
        sampleExpenseItem1.value = 249.90
        sampleExpenseItem1.date = Date()
        sampleExpenseItem1.isInstalment = false
        sampleExpenseItem1.instalments = 0
        
        let sampleExpenseItem2 = Item(context: context)
        sampleExpenseItem2.title = "Cafeteira"
        sampleExpenseItem2.value = 85.0
        sampleExpenseItem2.date = Date()
        sampleExpenseItem2.isInstalment = false
        sampleExpenseItem2.instalments = 0

        let sampleExpensesTable = Table(context: context)
        sampleExpensesTable.title = "Gastos do mês"
        sampleExpensesTable.color = "red"
        sampleExpensesTable.totalAmount = 334.9
        sampleExpensesTable.item = NSSet.init(array: [sampleExpenseItem1, sampleExpenseItem2])
        
        //income table
        let sampleIncomeItem = Item(context: context)
        sampleIncomeItem.title = "Salário"
        sampleIncomeItem.value = 2500.0
        sampleIncomeItem.date = Date()
        sampleIncomeItem.isInstalment = false
        sampleIncomeItem.instalments = 0
        
        let sampleIncomesTable = Table(context: context)
        sampleIncomesTable.title = "Renda do mês"
        sampleIncomesTable.color = "green"
        sampleIncomesTable.totalAmount = 2500.0
        sampleIncomesTable.item = NSSet.init(array: [sampleIncomeItem])
        
        //left over table
        let sampleLeftOverTable = Table(context: context)
        sampleLeftOverTable.title = "Reserva do mês"
        sampleLeftOverTable.color = "blue"
        sampleLeftOverTable.totalAmount = 2165.1
        sampleLeftOverTable.item = NSSet.init(array: [])
        
        let newSheet = Sheet(context: context)
        newSheet.title = "Planilha exemplo"
        newSheet.date = Date()
        newSheet.table = NSSet.init(array: [sampleIncomesTable, sampleExpensesTable, sampleLeftOverTable])
        
        Sheet.insertSheet(from: context)
    }
    
    func delete(sheet: Sheet) {
        Sheet.deleteSheet(from: context, sheet: sheet)
    }
}
