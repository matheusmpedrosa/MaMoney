//
//  SheetsViewController.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 20/02/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import UIKit

class SheetsViewController: UITableViewController {

    private var viewTitle: String
    private var sheets: [Sheet]
    
    init(viewTitle: String, sheets: [Sheet]) {
        self.viewTitle = viewTitle
        self.sheets = sheets
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewUI()
        registerCell()
    }
    
    private func setupViewUI() {
        self.title = viewTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.tableFooterView = UIView()
    }
    
    private func registerCell() {
        tableView.register(SheetTableViewCell.self, forCellReuseIdentifier: String(describing: SheetTableViewCell.self))
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sheets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SheetTableViewCell.self),
                                                       for: indexPath) as? SheetTableViewCell else {
            fatalError("Could not dequeue TableTableViewCell.")
        }
        cell.setup(sheet: sheets[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sheet = sheets[indexPath.row]
//        let tablesViewController = TablesViewController(viewTitle: sheet.title, tables: sheet.tables)
        let tabBarViewController = TabBarViewController(sheet: sheet)
        navigationController?.pushViewController(tabBarViewController, animated: true)
    }

}
