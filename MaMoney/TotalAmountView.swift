//
//  TotalAmountView.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 09/02/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import UIKit

class TotalAmountView: UIView {
    fileprivate lazy var backgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemGroupedBackground
        return view
    }()
    
    fileprivate lazy var separatorView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()
    
    fileprivate lazy var accessibilityContainer: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isAccessibilityElement = true
        view.accessibilityTraits = .staticText
        return view
    }()
    
    fileprivate lazy var title: UILabel = {
        var label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "TOTAL:"
        label.textColor = .label
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.accessibilityElementsHidden = true
        return label
    }()
    
    fileprivate lazy var subtitle: UILabel = {
        var label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "R$ 0,00"
        label.textColor = .label
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.accessibilityElementsHidden = true
        return label
    }()
    
    fileprivate var commomConstraints: [NSLayoutConstraint] = []
    fileprivate var regularConstraints: [NSLayoutConstraint] = []
    fileprivate var largeTextConstraints: [NSLayoutConstraint] = []
    fileprivate let verticalAnchorConstraint: CGFloat = 15.0
    fileprivate let horizontalAnchorConstraint: CGFloat = 20.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup(total: String?) {
        guard let total = total else { return }
        subtitle.text = total
        accessibilityContainer.accessibilityLabel = "total: \(total)"
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

extension TotalAmountView: ViewConfiguration {
    func buildViewHierarchy() {
        backgroundView.addSubview(separatorView)
        backgroundView.addSubview(accessibilityContainer)
        backgroundView.addSubview(title)
        backgroundView.addSubview(subtitle)

        self.addSubview(backgroundView)
    }
    
    func setupConstraints() {
        var bottonAnchor: CGFloat
        
        
        if UIDevice.current.hasNotch {
            bottonAnchor = -verticalAnchorConstraint - HeightConstants.kNotchHeight.rawValue
        } else {
            bottonAnchor = -verticalAnchorConstraint
        }
        
        commomConstraints = [
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            accessibilityContainer.topAnchor.constraint(equalTo: backgroundView.topAnchor,
                                                        constant: 8),
            accessibilityContainer.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor,
                                                            constant: 8),
            accessibilityContainer.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor,
                                                             constant: -8),

            separatorView.topAnchor.constraint(equalTo: backgroundView.topAnchor),
            separatorView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1.0)
        ]
        
        regularConstraints = [
            title.topAnchor.constraint(equalTo: backgroundView.topAnchor,
                                       constant: verticalAnchorConstraint),
            title.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                           constant: horizontalAnchorConstraint),
            title.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor,
                                          constant: bottonAnchor),
            
            accessibilityContainer.heightAnchor.constraint(equalTo: subtitle.heightAnchor,
                                                           constant: 15),
            
            subtitle.topAnchor.constraint(equalTo: backgroundView.topAnchor,
                                          constant: verticalAnchorConstraint),
            subtitle.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                                               constant: -horizontalAnchorConstraint),
            subtitle.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor,
                                             constant: bottonAnchor),
        ]
        
        largeTextConstraints = [
            title.topAnchor.constraint(equalTo: backgroundView.topAnchor,
                                       constant: verticalAnchorConstraint),
            title.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                           constant: horizontalAnchorConstraint),
            title.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor,
                                            constant: -horizontalAnchorConstraint),
            
            accessibilityContainer.heightAnchor.constraint(equalTo: subtitle.heightAnchor,
                                                           multiplier: 2.0,
                                                           constant: 15),
            
            subtitle.firstBaselineAnchor.constraint(equalToSystemSpacingBelow: title.lastBaselineAnchor,
                                                    multiplier: 1.0),
            subtitle.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                                              constant: horizontalAnchorConstraint),
            subtitle.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor,
                                               constant: -horizontalAnchorConstraint),
            subtitle.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor,
                                             constant: bottonAnchor),
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
