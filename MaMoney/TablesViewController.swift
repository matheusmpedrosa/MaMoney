//
//  TablesViewController.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 09/02/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import UIKit

class TablesViewController: UIViewController {
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    private var tables: [Table]
    
    fileprivate var commomConstraints: [NSLayoutConstraint] = []
    
    init(tables: [Table]) {
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
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.tintColor = .systemBlue
    }
    
    private func setupViewUI() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.backgroundColor = .systemBackground
        self.tableView.tableFooterView = UIView()
    }
    
    private func registerCell() {
        tableView.register(TableTableViewCell.self, forCellReuseIdentifier: String(describing: TableTableViewCell.self))
    }
}

extension TablesViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tables.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableTableViewCell.self),
                                                       for: indexPath) as? TableTableViewCell else {
            fatalError("Could not dequeue TableTableViewCell.")
        }
        let table = tables[indexPath.row]
        cell.setup(table: table)
        return cell
    }
    
}

extension TablesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let table = tables[indexPath.row]
        if table.title != "Reserva do mês" {
            let itemsViewController = ItemsViewController(table: table)
            navigationController?.pushViewController(itemsViewController, animated: true)
        }
    }

}

extension TablesViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        commomConstraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        updateLayoutConstraints()
    }
    
    func updateLayoutConstraints() {
        NSLayoutConstraint.activate(commomConstraints)
    }
}
