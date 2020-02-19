//
//  SheetTableViewController.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 09/02/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import UIKit

public enum HeightConstants: CGFloat {
    case kNotchHeight = 34.0
    case kFooterViewAccessibilityHeight = 120.0
    case kFooterViewHeight = 40.0
}

class SheetTableViewController: UIViewController {
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        return tableView
    }()

    fileprivate var viewTitle: String
    fileprivate var sheet: Sheet
    fileprivate var footerView = TotalAmountView(frame: .zero)
    
    fileprivate var commomConstraints: [NSLayoutConstraint] = []
    fileprivate var regularConstraints: [NSLayoutConstraint] = []
    fileprivate var largeTextConstraints: [NSLayoutConstraint] = []
    
    init(sheet: Sheet) {
        self.viewTitle = sheet.title
        self.sheet = sheet
        let total = sheet.totalAmount?.toBrazilianRealString()
        self.footerView.setup(total: total)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewUI()
        registerCell()
        configureView()
    }
    
    private func setupViewUI() {
        self.title = viewTitle
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = sheet.color
        self.navigationController?.navigationBar.backgroundColor = .systemBackground
        self.tableView.tableFooterView = UIView()
    }
    
    private func registerCell() {
        tableView.register(SheetItemsTableViewCell.self, forCellReuseIdentifier: "sheetItemsCell")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        let accessibilityCategory = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
        if accessibilityCategory != previousTraitCollection?.preferredContentSizeCategory.isAccessibilityCategory {
            updateLayoutConstraints()
        }
    }
}

    
extension SheetTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sheet.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sheetItemsCell", for: indexPath) as? SheetItemsTableViewCell else {
            fatalError("Could not dequeue SheetItemsTableViewCell.")
        }
        cell.setup(sheet: sheet.items[indexPath.row])
        return cell
    }
}

extension SheetTableViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(footerView)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        commomConstraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: footerView.topAnchor),
            
            footerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        if UIDevice.current.hasNotch {
            regularConstraints = [
//                footerView.heightAnchor.constraint(equalToConstant: HeightConstants.kNotchHeight.rawValue
//                                                                    + HeightConstants.kFooterViewHeight.rawValue)
            ]
            
            largeTextConstraints = [
//                footerView.heightAnchor.constraint(equalToConstant: HeightConstants.kNotchHeight.rawValue
//                                                                    + HeightConstants.kFooterViewAccessibilityHeight.rawValue)
            ]
        } else {
            regularConstraints = [
//                footerView.heightAnchor.constraint(equalToConstant: HeightConstants.kFooterViewHeight.rawValue)
            ]
            
            largeTextConstraints = [
//                footerView.heightAnchor.constraint(equalToConstant: HeightConstants.kFooterViewAccessibilityHeight.rawValue)
            ]
        }
        
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
