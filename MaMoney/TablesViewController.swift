//
//  TablesViewController.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 09/02/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import UIKit

class TablesViewController: UITableViewController {
    
    private var viewTitle: String
    private var tables: [Table]
    
    init(viewTitle: String, tables: [Table]) {
        self.viewTitle = viewTitle
        self.tables = tables
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.tintColor = .systemBlue
    }
    
    private func setupViewUI() {
        self.title = viewTitle
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.tableView.tableFooterView = UIView()
    }
    
    private func registerCell() {
        tableView.register(TableTableViewCell.self, forCellReuseIdentifier: String(describing: TableTableViewCell.self))
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tables.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableTableViewCell.self),
                                                       for: indexPath) as? TableTableViewCell else {
            fatalError("Could not dequeue TableTableViewCell.")
        }
        cell.setup(sheet: tables[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let table = tables[indexPath.row]
        let itemsViewController = ItemsViewController(table: table)
        navigationController?.pushViewController(itemsViewController, animated: true)
    }
}
