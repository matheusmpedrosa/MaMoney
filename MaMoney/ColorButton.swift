//
//  ColorButton.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 18/05/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import UIKit

protocol DidTapColorButtonDelegate: AnyObject {
    func didTapColorButton(button: ColorButton)
}

class ColorButton: UIButton {
    
    private var name: String?
    weak var delegate: DidTapColorButtonDelegate?
    
    init(frame: CGRect = .zero,
         backgroundColor: UIColor,
         name: String?,
         delegate: DidTapColorButtonDelegate?) {
        super.init(frame: frame)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 22
        self.tintColor = .white
        self.name = name
        self.delegate = delegate
        self.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func getName() -> String? {
        return self.name
    }
    
    public func setImage(image: UIImage?) {
        self.setImage(image, for: .normal)
    }
    
    @objc
    private func didTapButton() {
        delegate?.didTapColorButton(button: self)
    }
    
}
