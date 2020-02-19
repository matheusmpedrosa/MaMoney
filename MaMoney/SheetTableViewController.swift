//
//  SheetTableViewController.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 09/02/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import UIKit

enum HeightConstants: CGFloat {
    case kNotchHeight = 34.0
    case kFooterViewAccessibilityHeight = 80.0
    case kFooterViewHeight = 40.0
}

class SheetTableViewController: UIViewController {
    var viewTitle: String
    var sheet: Sheet
    var footerView = TotalAmountView(frame: .zero)
    
    lazy private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = self
        return tableView
    }()
    
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
            setupConstraints()
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
        if UIDevice.current.hasNotch {
            if traitCollection.preferredContentSizeCategory.isAccessibilityCategory {
                footerView.anchor(top: nil, paddingTop: 0,
                                  bottom: view.bottomAnchor, paddingBottom: 0,
                                  left: view.safeAreaLayoutGuide.leftAnchor, paddingLeft: 0,
                                  right: view.safeAreaLayoutGuide.rightAnchor, paddingRight: 0,
                                  width: 0, height: HeightConstants.kNotchHeight.rawValue
                                                    + HeightConstants.kFooterViewAccessibilityHeight.rawValue)
            } else {
                footerView.anchor(top: nil, paddingTop: 0,
                                  bottom: view.bottomAnchor, paddingBottom: 0,
                                  left: view.safeAreaLayoutGuide.leftAnchor, paddingLeft: 0,
                                  right: view.safeAreaLayoutGuide.rightAnchor, paddingRight: 0,
                                  width: 0, height: HeightConstants.kNotchHeight.rawValue
                                                    + HeightConstants.kFooterViewHeight.rawValue)
            }
        } else {
            if traitCollection.preferredContentSizeCategory.isAccessibilityCategory {
                footerView.anchor(top: nil, paddingTop: 0,
                                  bottom: view.bottomAnchor, paddingBottom: 0,
                                  left: view.safeAreaLayoutGuide.leftAnchor, paddingLeft: 0,
                                  right: view.safeAreaLayoutGuide.rightAnchor, paddingRight: 0,
                                  width: 0, height: HeightConstants.kFooterViewAccessibilityHeight.rawValue)
            } else {
                footerView.anchor(top: nil, paddingTop: 0,
                                  bottom: view.bottomAnchor, paddingBottom: 0,
                                  left: view.safeAreaLayoutGuide.leftAnchor, paddingLeft: 0,
                                  right: view.safeAreaLayoutGuide.rightAnchor, paddingRight: 0,
                                  width: 0, height: HeightConstants.kFooterViewHeight.rawValue)
            }
        }
        
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 0,
                         bottom: footerView.topAnchor, paddingBottom: 0,
                         left: view.leftAnchor, paddingLeft: 0,
                         right: view.rightAnchor, paddingRight: 0,
                         width: 0, height: 0)
    }
}
