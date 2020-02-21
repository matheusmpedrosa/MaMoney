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
    
    public func setup(sheet: Table) {
        self.textLabel?.text = sheet.title
        self.detailTextLabel?.text = sheet.totalAmount?.toBrazilianRealString()
        self.imageView?.image = sheet.color.image(CGSize(width: edge, height: edge))
        self.imageView?.layer.cornerRadius = edge / 2.0
        self.imageView?.clipsToBounds = true
        self.selectionStyle = .none
    }

}
