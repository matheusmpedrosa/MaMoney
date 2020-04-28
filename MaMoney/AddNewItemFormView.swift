//
//  AddNewItemFormView.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 23/03/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import UIKit

class AddNewItemFormView: UIView {
    
    fileprivate lazy var backgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    fileprivate lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.backgroundColor = .systemBackground
        return view
    }()
    
    fileprivate lazy var headerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add new item"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    fileprivate lazy var titleTextField = InputTextField()
    
    fileprivate lazy var isInstalmentLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Is instalment?"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    fileprivate lazy var isInstalmentSwitch: UISwitch = {
        let `switch` = UISwitch(frame: .zero)
        `switch`.translatesAutoresizingMaskIntoConstraints = false
        return `switch`
    }()
    
    fileprivate lazy var numberOfInstalmentsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Number of instalments"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    fileprivate lazy var numberOfInstalmentsStepper: UIStepper = {
        let stepper = UIStepper(frame: .zero)
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    
    fileprivate lazy var instalmentsCountLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "0"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    fileprivate lazy var valueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Value"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    fileprivate lazy var valueTextField = InputTextField()
    
    fileprivate lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Date"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    fileprivate lazy var dateTextField = InputTextField()
    
    fileprivate lazy var saveButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.backgroundColor = .systemBlue
        button.setTitle("Save and dismiss", for: .normal)
        button.titleLabel?.textColor = .systemBackground
        return button
    }()
    
    fileprivate var commomConstraints: [NSLayoutConstraint] = []
    fileprivate var regularConstraints: [NSLayoutConstraint] = []
    fileprivate var largeTextConstraints: [NSLayoutConstraint] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddNewItemFormView: ViewConfiguration {
    func buildViewHierarchy() {
        containerView.addSubview(headerLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(titleTextField)
        containerView.addSubview(isInstalmentLabel)
        containerView.addSubview(isInstalmentSwitch)
        containerView.addSubview(numberOfInstalmentsLabel)
        containerView.addSubview(numberOfInstalmentsStepper)
        containerView.addSubview(instalmentsCountLabel)
        containerView.addSubview(valueLabel)
        containerView.addSubview(valueTextField)
        containerView.addSubview(dateLabel)
        containerView.addSubview(dateTextField)
        containerView.addSubview(saveButton)

        backgroundView.addSubview(containerView)
        
        self.addSubview(backgroundView)
    }
    
    func setupConstraints() {
        commomConstraints = [
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: headerLabel.topAnchor, constant: -16),
            containerView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            
            headerLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -8),
            headerLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            
            titleLabel.bottomAnchor.constraint(equalTo: titleTextField.topAnchor, constant: -4),
            titleLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            titleLabel.heightAnchor.constraint(equalToConstant: 24),
            
            titleTextField.bottomAnchor.constraint(equalTo: isInstalmentLabel.topAnchor, constant: -16),
            titleTextField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            
            isInstalmentLabel.bottomAnchor.constraint(equalTo: isInstalmentSwitch.topAnchor, constant: -4),
            isInstalmentLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            isInstalmentLabel.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 0.5),
            isInstalmentLabel.heightAnchor.constraint(equalToConstant: 24),
            
            isInstalmentSwitch.bottomAnchor.constraint(equalTo: valueLabel.topAnchor, constant: -16),
            isInstalmentSwitch.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            
            numberOfInstalmentsLabel.bottomAnchor.constraint(equalTo: numberOfInstalmentsStepper.topAnchor, constant: -4),
            numberOfInstalmentsLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            numberOfInstalmentsLabel.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 0.5),
            numberOfInstalmentsLabel.heightAnchor.constraint(equalToConstant: 24),
            
            numberOfInstalmentsStepper.bottomAnchor.constraint(equalTo: isInstalmentSwitch.bottomAnchor),
            numberOfInstalmentsStepper.leadingAnchor.constraint(equalTo: numberOfInstalmentsLabel.leadingAnchor),
            
            instalmentsCountLabel.centerYAnchor.constraint(equalTo: numberOfInstalmentsStepper.centerYAnchor),
            instalmentsCountLabel.leadingAnchor.constraint(equalTo: numberOfInstalmentsStepper.trailingAnchor, constant: 16),
            
            valueLabel.bottomAnchor.constraint(equalTo: valueTextField.topAnchor, constant: -4),
            valueLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            valueLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            valueLabel.heightAnchor.constraint(equalToConstant: 24),
            
            valueTextField.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -16),
            valueTextField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            valueTextField.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            
            dateLabel.bottomAnchor.constraint(equalTo: dateTextField.topAnchor, constant: -4),
            dateLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            dateLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            dateLabel.heightAnchor.constraint(equalToConstant: 24),
            
            dateTextField.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -20),
            dateTextField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            dateTextField.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            
            saveButton.bottomAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.bottomAnchor),
            saveButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            saveButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            saveButton.heightAnchor.constraint(equalToConstant: 55)
        ]
        
        updateLayoutConstraints()
    }
    
    func updateLayoutConstraints() {
        NSLayoutConstraint.activate(commomConstraints)
    }
    
    
}
