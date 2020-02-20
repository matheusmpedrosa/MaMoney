//
//  SheetItemsTableViewCell.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 09/02/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import UIKit

class SheetItemsTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(sheet: SheetItem) {
        self.textLabel?.text = sheet.title
        self.textLabel?.numberOfLines = 0
        self.textLabel?.lineBreakMode = .byWordWrapping
        self.detailTextLabel?.text = sheet.value.toBrazilianRealString()
        self.detailTextLabel?.numberOfLines = 0
        self.detailTextLabel?.lineBreakMode = .byWordWrapping
        self.selectionStyle = .none
    }

}
