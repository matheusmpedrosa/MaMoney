//
//  InputTextField.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 09/04/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import UIKit

class InputTextField: UITextField {

    init(frame: CGRect = .zero,
         placeHolder: String = "",
         text: String = "",
         backgroundColor: UIColor = .tertiarySystemBackground,
         textAlignment: NSTextAlignment = .left,
         borderStyle: BorderStyle = .roundedRect,
         clearButtonMode: ViewMode = .whileEditing) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isAccessibilityElement = true
        self.placeholder = placeHolder
        self.text = text
        self.backgroundColor = backgroundColor
        self.textAlignment = textAlignment
        self.borderStyle = borderStyle
        self.clearButtonMode = clearButtonMode
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
