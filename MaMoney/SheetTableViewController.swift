//
//  SheetTableViewController.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 09/02/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import UIKit

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
        self.title = viewTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = sheet.color
        self.tableView.tableFooterView = UIView()
        registerCell()
        configureView()
        footerView.backgroundColor = .red
    }
    
    private func registerCell() {
        tableView.register(SheetItemsTableViewCell.self, forCellReuseIdentifier: "sheetItemsCell")
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
            footerView.anchor(top: nil, paddingTop: 0,
                              bottom: view.bottomAnchor, paddingBottom: 0,
                              left: view.safeAreaLayoutGuide.leftAnchor, paddingLeft: 0,
                              right: view.safeAreaLayoutGuide.rightAnchor, paddingRight: 0,
                              width: 0, height: 40+34)
        } else {
            footerView.anchor(top: nil, paddingTop: 0,
                              bottom: view.bottomAnchor, paddingBottom: 0,
                              left: view.safeAreaLayoutGuide.leftAnchor, paddingLeft: 0,
                              right: view.safeAreaLayoutGuide.rightAnchor, paddingRight: 0,
                              width: 0, height: 40)
        }
        
        tableView.anchor(top: view.topAnchor, paddingTop: 0,
                         bottom: footerView.topAnchor, paddingBottom: 0,
                         left: view.leftAnchor, paddingLeft: 0,
                         right: view.rightAnchor, paddingRight: 0,
                         width: 0, height: 0)
    }
}
