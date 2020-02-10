//
//  TotalAmountView.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 09/02/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import UIKit

class TotalAmountView: UIView {
    
    lazy var backgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .secondarySystemGroupedBackground
        return view
    }()
    
    lazy var separatorView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemGray5
        return view
    }()
    
    lazy var title: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = "TOTAL:"
        label.textColor = .label
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    lazy var subtitle: UILabel = {
        var label = UILabel(frame: .zero)
        label.text = "R$ 0,00"
        label.textColor = .label
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(total: String?) {
        guard let total = total else { return }
        subtitle.text = total
    }
}

extension TotalAmountView: ViewConfiguration {
    func buildViewHierarchy() {
        backgroundView.addSubview(separatorView)
        backgroundView.addSubview(title)
        backgroundView.addSubview(subtitle)

        self.addSubview(backgroundView)
    }
    
    func setupConstraints() {
        backgroundView.anchor(top: self.topAnchor, paddingTop: 0,
                              bottom: self.bottomAnchor, paddingBottom: 0,
                              left: self.leftAnchor, paddingLeft: 0,
                              right: self.rightAnchor, paddingRight: 0,
                              width: 0, height: 0)

        separatorView.anchor(top: backgroundView.topAnchor, paddingTop: 0,
                             bottom: nil, paddingBottom: 0,
                             left: backgroundView.leftAnchor, paddingLeft: 0,
                             right: backgroundView.rightAnchor, paddingRight: 0,
                             width: 0, height: 1)

        title.anchor(top: backgroundView.topAnchor, paddingTop: 20,
                     bottom: nil, paddingBottom: 0,
                     left: backgroundView.leftAnchor, paddingLeft: 20,
                     right: nil, paddingRight: 0,
                     width: 0, height: 0)

        subtitle.anchor(top: backgroundView.topAnchor, paddingTop: 20,
                        bottom: nil, paddingBottom: 0,
                        left: nil, paddingLeft: 0,
                        right: backgroundView.rightAnchor, paddingRight: 20,
                        width: 0, height: 0)
    }
}
