//
//  AddNewTableFormView.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 18/05/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import UIKit

protocol DidSelectTableColorDelegate: AnyObject {
    func didSelectTableColor(color: String?)
}

class AddNewTableFormView: UIView {
    
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
        label.text = "Adicionar nova tabela"
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Título"
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    fileprivate lazy var titleTextField = InputTextField()
    
    fileprivate lazy var colorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cor"
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    fileprivate lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.addArrangedSubview(self.topHorizontalStackView)
        stackView.addArrangedSubview(self.bottomHorizontalStackView)
        return stackView
    }()
    
    fileprivate lazy var topHorizontalStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(redButton)
        stackView.addArrangedSubview(orangeButton)
        stackView.addArrangedSubview(yellowButton)
        stackView.addArrangedSubview(greenButton)
        stackView.addArrangedSubview(blueButton)
        return stackView
    }()
    
    fileprivate lazy var bottomHorizontalStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(pinkButton)
        stackView.addArrangedSubview(purpleButton)
        stackView.addArrangedSubview(indigoButton)
        stackView.addArrangedSubview(tealButton)
        stackView.addArrangedSubview(grayButton)
        return stackView
    }()
    
    fileprivate lazy var redButton = ColorButton(backgroundColor: .systemRed, name: "red", delegate: self)
    fileprivate lazy var greenButton = ColorButton(backgroundColor: .systemGreen, name: "green", delegate: self)
    fileprivate lazy var blueButton = ColorButton(backgroundColor: .systemBlue, name: "blue", delegate: self)
    fileprivate lazy var orangeButton = ColorButton(backgroundColor: .systemOrange, name: "orange", delegate: self)
    fileprivate lazy var yellowButton = ColorButton(backgroundColor: .systemYellow, name: "yellow", delegate: self)
    fileprivate lazy var pinkButton = ColorButton(backgroundColor: .systemPink, name: "pink", delegate: self)
    fileprivate lazy var purpleButton = ColorButton(backgroundColor: .systemPurple, name: "purple", delegate: self)
    fileprivate lazy var tealButton = ColorButton(backgroundColor: .systemTeal, name: "teal", delegate: self)
    fileprivate lazy var indigoButton = ColorButton(backgroundColor: .systemIndigo, name: "indigo", delegate: self)
    fileprivate lazy var grayButton = ColorButton(backgroundColor: .systemGray, name: "gray", delegate: self)
    
    fileprivate lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 12
        button.backgroundColor = .systemBlue
        button.setTitle("Salvar", for: .normal)
        button.setTitle("Salvar", for: .disabled)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white, for: .disabled)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        button.addTarget(self, action: #selector(saveButtonWasTapped), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    fileprivate var commomConstraints: [NSLayoutConstraint] = []
    fileprivate let leadingConstant: CGFloat = 32
    fileprivate let trailingConstant: CGFloat = -32
    fileprivate let shortVerticalSpace: CGFloat = -4
    fileprivate let longVerticalSpace: CGFloat = -16
    fileprivate let colorButtonSquare: CGFloat = 44
    
    weak var titleTextFieldDidChangeValueDelegate: TitleTextFieldDidChangeValueProtocol?
    weak var didSelectTableColorDelegate: DidSelectTableColorDelegate?
    weak var didTapSaveButtonDelegate: SaveButtonWasTappedProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        titleTextField.delegate = self
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func saveButtonWasTapped() {
        didTapSaveButtonDelegate?.saveButtonWasTapped()
    }
}

extension AddNewTableFormView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if titleTextField.text != "" {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
        if textField == titleTextField {
            titleTextFieldDidChangeValueDelegate?.titleTextFieldDidChangeValue(title: textField.text ?? "")
        }
    }
}

extension AddNewTableFormView: DidTapColorButtonDelegate {
    func didTapColorButton(button: ColorButton) {
        let colorButtons: [ColorButton] = [redButton, greenButton, blueButton, orangeButton, yellowButton, pinkButton, purpleButton, tealButton, indigoButton, grayButton]
        
        if colorButtons.contains(button) {
            didSelectTableColorDelegate?.didSelectTableColor(color:button.getName())
            button.setImage(image: #imageLiteral(resourceName: "icn-checkmark"))
            button.alpha = 1
            for button in colorButtons.filter({ $0 != button }) {
                button.setImage(image: nil)
                button.alpha = 0.6
            }
        }
    }
}

extension AddNewTableFormView: ViewConfiguration {
    func buildViewHierarchy() {
        containerView.addSubview(headerLabel)
        containerView.addSubview(titleLabel)
        containerView.addSubview(titleTextField)
        containerView.addSubview(colorLabel)
        containerView.addSubview(verticalStackView)
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
            
            titleTextField.bottomAnchor.constraint(equalTo: colorLabel.topAnchor, constant: longVerticalSpace),
            titleTextField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: leadingConstant),
            titleTextField.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: trailingConstant),
            
            colorLabel.bottomAnchor.constraint(equalTo: verticalStackView.topAnchor, constant: shortVerticalSpace),
            colorLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: leadingConstant),
            colorLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: leadingConstant),
            
            verticalStackView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: longVerticalSpace),
            verticalStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: leadingConstant),
            verticalStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: trailingConstant),
            
            redButton.heightAnchor.constraint(equalToConstant: colorButtonSquare),
            redButton.widthAnchor.constraint(equalToConstant: colorButtonSquare),
            
            greenButton.heightAnchor.constraint(equalToConstant: colorButtonSquare),
            greenButton.widthAnchor.constraint(equalToConstant: colorButtonSquare),
            
            blueButton.heightAnchor.constraint(equalToConstant: colorButtonSquare),
            blueButton.widthAnchor.constraint(equalToConstant: colorButtonSquare),
            
            orangeButton.heightAnchor.constraint(equalToConstant: colorButtonSquare),
            orangeButton.widthAnchor.constraint(equalToConstant: colorButtonSquare),
            
            yellowButton.heightAnchor.constraint(equalToConstant: colorButtonSquare),
            yellowButton.widthAnchor.constraint(equalToConstant: colorButtonSquare),
            
            pinkButton.heightAnchor.constraint(equalToConstant: colorButtonSquare),
            pinkButton.widthAnchor.constraint(equalToConstant: colorButtonSquare),
            
            purpleButton.heightAnchor.constraint(equalToConstant: colorButtonSquare),
            purpleButton.widthAnchor.constraint(equalToConstant: colorButtonSquare),
            
            tealButton.heightAnchor.constraint(equalToConstant: colorButtonSquare),
            tealButton.widthAnchor.constraint(equalToConstant: colorButtonSquare),
            
            indigoButton.heightAnchor.constraint(equalToConstant: colorButtonSquare),
            indigoButton.widthAnchor.constraint(equalToConstant: colorButtonSquare),
            
            grayButton.heightAnchor.constraint(equalToConstant: colorButtonSquare),
            grayButton.widthAnchor.constraint(equalToConstant: colorButtonSquare),
            
            saveButton.bottomAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.bottomAnchor),
            saveButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: leadingConstant),
            saveButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: trailingConstant),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        updateLayoutConstraints()
    }
    
    func updateLayoutConstraints() {
         NSLayoutConstraint.activate(commomConstraints)
    }
    
    
}
