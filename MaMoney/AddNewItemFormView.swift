//
//  AddNewItemFormView.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 23/03/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import UIKit

protocol DidTapSaveButtonProtocol {
    func didTapSaveButton()
}

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
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    fileprivate lazy var titleTextField = InputTextField()
    
    fileprivate lazy var isInstalmentLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Is instalment?"
        label.adjustsFontForContentSizeCategory = true
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
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.adjustsFontForContentSizeCategory = true
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
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    fileprivate lazy var valueLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Value"
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    fileprivate lazy var valueTextField = InputTextField()
    
    fileprivate lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Date"
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    fileprivate lazy var dateTextField = InputTextField()
    
    fileprivate lazy var saveButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.backgroundColor = .systemBlue
        button.setTitle("Save", for: .normal)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
        return button
    }()
    
    fileprivate var commomConstraints: [NSLayoutConstraint] = []
    fileprivate var regularConstraints: [NSLayoutConstraint] = []
    fileprivate var largeTextConstraints: [NSLayoutConstraint] = []
    fileprivate let leadingConstant: CGFloat = 32
    fileprivate let trailingConstant: CGFloat = -32
    fileprivate let shortVerticalSpace: CGFloat = -4
    fileprivate let longVerticalSpace: CGFloat = -16
    
    var delegate: DidTapSaveButtonProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func didTapSaveButton() {
        delegate?.didTapSaveButton()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
           let accessibilityCategory = traitCollection
                                       .preferredContentSizeCategory
                                       .isAccessibilityCategory
           if accessibilityCategory != previousTraitCollection?
                                       .preferredContentSizeCategory
                                       .isAccessibilityCategory {
               updateLayoutConstraints()
           }
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
            
            containerView.topAnchor.constraint(equalTo: headerLabel.topAnchor, constant: trailingConstant),
            containerView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            
            headerLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: longVerticalSpace),
            headerLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: leadingConstant),
            headerLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: trailingConstant),
            
            titleLabel.bottomAnchor.constraint(equalTo: titleTextField.topAnchor, constant: shortVerticalSpace),
            titleLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: leadingConstant),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: trailingConstant),
            
            titleTextField.bottomAnchor.constraint(equalTo: isInstalmentLabel.topAnchor, constant: longVerticalSpace),
            titleTextField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: leadingConstant),
            titleTextField.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: trailingConstant),
            
            isInstalmentLabel.bottomAnchor.constraint(equalTo: isInstalmentSwitch.topAnchor, constant: shortVerticalSpace),
            isInstalmentLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: leadingConstant),
            
            isInstalmentSwitch.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: leadingConstant),
            
            instalmentsCountLabel.centerYAnchor.constraint(equalTo: numberOfInstalmentsStepper.centerYAnchor),
            instalmentsCountLabel.leadingAnchor.constraint(equalTo: numberOfInstalmentsStepper.trailingAnchor, constant: leadingConstant),
            
            valueLabel.bottomAnchor.constraint(equalTo: valueTextField.topAnchor, constant: shortVerticalSpace),
            valueLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: leadingConstant),
            valueLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: trailingConstant),
            
            valueTextField.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: longVerticalSpace),
            valueTextField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: leadingConstant),
            valueTextField.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: trailingConstant),
            
            dateLabel.bottomAnchor.constraint(equalTo: dateTextField.topAnchor, constant: shortVerticalSpace),
            dateLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: leadingConstant),
            dateLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: trailingConstant),
            
            dateTextField.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: longVerticalSpace),
            dateTextField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: leadingConstant),
            dateTextField.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: trailingConstant),
            
            saveButton.bottomAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.bottomAnchor),
            saveButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: leadingConstant),
            saveButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: trailingConstant),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        regularConstraints = [
            isInstalmentLabel.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 0.5),
            
            isInstalmentSwitch.bottomAnchor.constraint(equalTo: valueLabel.topAnchor, constant: longVerticalSpace),
            
            numberOfInstalmentsLabel.bottomAnchor.constraint(equalTo: numberOfInstalmentsStepper.topAnchor, constant: shortVerticalSpace),
            numberOfInstalmentsLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: trailingConstant),
            numberOfInstalmentsLabel.widthAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 0.5),
            
            numberOfInstalmentsStepper.bottomAnchor.constraint(equalTo: isInstalmentSwitch.bottomAnchor),
            numberOfInstalmentsStepper.leadingAnchor.constraint(equalTo: numberOfInstalmentsLabel.leadingAnchor)
        ]

        largeTextConstraints = [
            isInstalmentLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: trailingConstant),
            
            isInstalmentSwitch.bottomAnchor.constraint(equalTo: numberOfInstalmentsLabel.topAnchor, constant: longVerticalSpace),
            
            numberOfInstalmentsLabel.bottomAnchor.constraint(equalTo: numberOfInstalmentsStepper.topAnchor, constant: shortVerticalSpace),
            numberOfInstalmentsLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: leadingConstant),
            numberOfInstalmentsLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: trailingConstant),

            numberOfInstalmentsStepper.bottomAnchor.constraint(equalTo: valueLabel.topAnchor, constant: longVerticalSpace),
            numberOfInstalmentsStepper.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: leadingConstant)
        ]
        
        updateLayoutConstraints()
    }
    
    func updateLayoutConstraints() {
        NSLayoutConstraint.activate(commomConstraints)
        if traitCollection.preferredContentSizeCategory.isAccessibilityCategory {
            NSLayoutConstraint.deactivate(regularConstraints)
            NSLayoutConstraint.activate(largeTextConstraints)
        } else {
            NSLayoutConstraint.deactivate(largeTextConstraints)
            NSLayoutConstraint.activate(regularConstraints)
        }
    }
    
    
}
