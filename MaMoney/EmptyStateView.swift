//
//  EmptyStateView.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 14/05/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import Foundation
import UIKit

enum EmptyStateType {
    case sheet
    case table
    case item
    case graph
}

protocol AddButtonWasTappedProtocol: AnyObject {
    func addButtonWasTapped()
}

class EmptyStateView: UIView {
    
    fileprivate lazy var backgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    fileprivate lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .label
        button.setImage(#imageLiteral(resourceName: "icn-add-list"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "icn-add-list"), for: .selected)
        button.addTarget(self, action: #selector(addButtonWasTapped), for: .touchUpInside)
        return button
    }()
    
    fileprivate var type: EmptyStateType = .sheet
    weak var delegate: AddButtonWasTappedProtocol?
    
    fileprivate var commomConstraints: [NSLayoutConstraint] = []
    fileprivate var listConstraints: [NSLayoutConstraint] = []
    fileprivate var graphConstraints: [NSLayoutConstraint] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(type: EmptyStateType, delegate: AddButtonWasTappedProtocol) {
        self.type = type
        self.delegate = delegate
        configureView()
        setTitleFor(type: type)
    }
    
    private func setTitleFor(type: EmptyStateType) {
        switch type {
        case .sheet:
            self.titleLabel.text = "A lista de planilhas está vazia. Toque aqui para adicionar uma nova."
        case .table:
            self.titleLabel.text = "A lista de tabelas está vazia. Toque aqui para adicionar uma nova."
        case .item:
            self.titleLabel.text = "A lista de itens está vazia. Toque aqui para adicionar um novo."
        case .graph:
            self.titleLabel.text = "Os gráficos não podem ser exibidos, porque você ainda não tem tabelas adicionadas."
        }
    }
    
    @objc
    func addButtonWasTapped() {
        self.delegate?.addButtonWasTapped()
    }
}

extension EmptyStateView: ViewConfiguration {
    func buildViewHierarchy() {
        if type != .graph {
            backgroundView.addSubview(addButton)
        }
        backgroundView.addSubview(titleLabel)
        
        self.addSubview(backgroundView)
    }
    
    func setupConstraints() {
        commomConstraints = [
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        
        listConstraints = [
            titleLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor, constant: -80),
            titleLabel.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 0.8),
            
            addButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -40),
            addButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            addButton.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 0.8),
            addButton.heightAnchor.constraint(equalToConstant: 120)
        ]
        
        graphConstraints = [
            titleLabel.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            titleLabel.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 0.8)
        ]
        
        updateLayoutConstraints()
    }
    
    func updateLayoutConstraints() {
        NSLayoutConstraint.activate(commomConstraints)
        if type == .graph {
            NSLayoutConstraint.activate(graphConstraints)
        } else {
            NSLayoutConstraint.activate(listConstraints)
        }
    }
    
    
}
