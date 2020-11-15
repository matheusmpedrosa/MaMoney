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
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    fileprivate var sheet: Sheet
    fileprivate var tables: [Table] = []
    fileprivate var dataManager: TableDataManager
    fileprivate var emptyStateView = EmptyStateView(frame: .zero)
    
    fileprivate var commomConstraints: [NSLayoutConstraint] = []
    
    init(sheet: Sheet, tables: [Table], dataManager: TableDataManager) {
        self.sheet = sheet
        self.tables = tables
        self.dataManager = dataManager
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
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        emptyStateView.setup(type: .table, delegate: self)
    }
    
    private func registerCell() {
        tableView.register(TableTableViewCell.self, forCellReuseIdentifier: String(describing: TableTableViewCell.self))
    }
    
    private func fetchTables() {
        tables.removeAll()
        dataManager.fetchAll { [weak self] (allTables) in
            if let allTables = allTables as? [Table] {
                self?.tables = allTables.filter { $0.ofSheet == self?.sheet }
            } else {
                self?.tables = []
            }
            self?.tableView.reloadData()
        }
        
        if  tables.isEmpty {
            UIView.transition(with: emptyStateView, duration: 0.3, options: .curveEaseInOut, animations: {
                self.emptyStateView.alpha = 1
            }, completion: nil)
        } else {
            UIView.transition(with: emptyStateView, duration: 0.3, options: .curveEaseInOut, animations: {
                self.emptyStateView.alpha = 0
            }, completion: nil)
        }
    }
}

extension TablesViewController: AddButtonWasTappedProtocol {
    func addButtonWasTapped() { }
}

extension TablesViewController: DidDismissViewControllerDelegate {
    func didDismissViewController() {
        fetchTables()
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataManager.delete(object: tables[indexPath.row])
            tables.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            fetchTables()
        }
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
