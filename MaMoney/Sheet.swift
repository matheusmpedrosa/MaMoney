//
//  Sheet.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 20/02/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import Foundation

struct Sheet {
    var title: String = ""
    var date: Date = Date()
    var tables: [Table] = []
    
    func getJanuarySheetMock() -> Sheet {
        let mock: Sheet = Sheet(title: "jan/2020",
                                date: Date(),
                                tables: [Table().getMoneyInTableMock(),
                                         Table().getMoneyOutTableMock(),
                                         Table().getLeftOverTableMock(),
                                         Table().getRegularExpensesTableMock()
                                ])
        return mock
    }
}
