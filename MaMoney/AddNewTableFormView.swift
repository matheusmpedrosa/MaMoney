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
    
    fileprivate lazy var titleTextField = InputTextField(placeHolder: "Lorem ipsum...")
    
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
    fileprivate let kLeadingConstant: CGFloat = 32
    fileprivate let kTrailingConstant: CGFloat = -32
    fileprivate let kShortVerticalSpace: CGFloat = -4
    fileprivate let kLongVerticalSpace: CGFloat = -16
    fileprivate let kColorButtonSquare: CGFloat = 44
    
    weak var titleTextFieldDidChangeValueDelegate: TitleTextFieldDidChangeValueProtocol?
    weak var didSelectTableColorDelegate: DidSelectTableColorDelegate?
    weak var didTapSaveButtonDelegate: SaveButtonWasTappedProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        titleTextField.delegate = self
        configureView()
        redButton.didTapButton()
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
        if let text = titleTextField.text, text.isEmpty {
            saveButton.isEnabled = false
        } else {
            saveButton.isEnabled = true
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
            
            containerView.topAnchor.constraint(equalTo: headerLabel.topAnchor, constant: kTrailingConstant),
            containerView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor),
            
            headerLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: kLongVerticalSpace),
            headerLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: kLeadingConstant),
            headerLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: kTrailingConstant),
            
            titleLabel.bottomAnchor.constraint(equalTo: titleTextField.topAnchor, constant: kShortVerticalSpace),
            titleLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: kLeadingConstant),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: kTrailingConstant),
            
            titleTextField.bottomAnchor.constraint(equalTo: colorLabel.topAnchor, constant: kLongVerticalSpace),
            titleTextField.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: kLeadingConstant),
            titleTextField.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: kTrailingConstant),
            
            colorLabel.bottomAnchor.constraint(equalTo: verticalStackView.topAnchor, constant: kShortVerticalSpace),
            colorLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: kLeadingConstant),
            colorLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: kLeadingConstant),
            
            verticalStackView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: kLongVerticalSpace),
            verticalStackView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: kLeadingConstant),
            verticalStackView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: kTrailingConstant),
            
            redButton.heightAnchor.constraint(equalToConstant: kColorButtonSquare),
            redButton.widthAnchor.constraint(equalToConstant: kColorButtonSquare),
            
            greenButton.heightAnchor.constraint(equalToConstant: kColorButtonSquare),
            greenButton.widthAnchor.constraint(equalToConstant: kColorButtonSquare),
            
            blueButton.heightAnchor.constraint(equalToConstant: kColorButtonSquare),
            blueButton.widthAnchor.constraint(equalToConstant: kColorButtonSquare),
            
            orangeButton.heightAnchor.constraint(equalToConstant: kColorButtonSquare),
            orangeButton.widthAnchor.constraint(equalToConstant: kColorButtonSquare),
            
            yellowButton.heightAnchor.constraint(equalToConstant: kColorButtonSquare),
            yellowButton.widthAnchor.constraint(equalToConstant: kColorButtonSquare),
            
            pinkButton.heightAnchor.constraint(equalToConstant: kColorButtonSquare),
            pinkButton.widthAnchor.constraint(equalToConstant: kColorButtonSquare),
            
            purpleButton.heightAnchor.constraint(equalToConstant: kColorButtonSquare),
            purpleButton.widthAnchor.constraint(equalToConstant: kColorButtonSquare),
            
            tealButton.heightAnchor.constraint(equalToConstant: kColorButtonSquare),
            tealButton.widthAnchor.constraint(equalToConstant: kColorButtonSquare),
            
            indigoButton.heightAnchor.constraint(equalToConstant: kColorButtonSquare),
            indigoButton.widthAnchor.constraint(equalToConstant: kColorButtonSquare),
            
            grayButton.heightAnchor.constraint(equalToConstant: kColorButtonSquare),
            grayButton.widthAnchor.constraint(equalToConstant: kColorButtonSquare),
            
            saveButton.bottomAnchor.constraint(equalTo: backgroundView.safeAreaLayoutGuide.bottomAnchor),
            saveButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: kLeadingConstant),
            saveButton.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: kTrailingConstant),
            saveButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        updateLayoutConstraints()
    }
    
    func updateLayoutConstraints() {
         NSLayoutConstraint.activate(commomConstraints)
    }
    
    
}
