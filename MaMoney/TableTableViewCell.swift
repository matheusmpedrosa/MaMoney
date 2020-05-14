//
//  TableTableViewCell.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 09/02/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import UIKit

class TableTableViewCell: UITableViewCell {
    
    private let edge: CGFloat = 28
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(table: Table) {
        self.textLabel?.text = table.title
        self.detailTextLabel?.text = table.totalAmount.toBrazilianRealString()
        self.imageView?.image = table.color.colorFromString().image(CGSize(width: edge, height: edge))
        self.imageView?.layer.cornerRadius = edge / 2.0
        self.imageView?.clipsToBounds = true
        self.selectionStyle = .none
        if table.title != "Reserva do mês" {
            self.accessoryType = .disclosureIndicator
        }
    }

}
