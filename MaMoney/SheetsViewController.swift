//
//  SheetsViewController.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 20/02/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import UIKit
import CoreData

class SheetsViewController: UITableViewController {

    private var sheets: [Sheet] = []
    private var store: SheetStore
    
    init(store: SheetStore) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewUI()
        registerCell()
        fetchSheets()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    private func setupViewUI() {
        self.title = "Planilhas"
        self.navigationController?.navigationBar.tintColor = .systemBlue
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        self.tableView.tableFooterView = UIView()
    }
    
    private func registerCell() {
        tableView.register(SheetTableViewCell.self, forCellReuseIdentifier: String(describing: SheetTableViewCell.self))
    }
    
    private func fetchSheets() {
        store.fetchAll { [weak self] (sheets) in
            if let sheets = sheets {
                self?.sheets = sheets
            } else {
                //show empty state
                self?.sheets = []
            }
            self?.tableView.reloadData()
        }
    }
    
    @objc
    private func addItem() {
        store.insert()
        fetchSheets()
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
        let tabBarViewController = TabBarViewController(sheet: sheet)
        navigationController?.pushViewController(tabBarViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            store.delete(sheet: sheets[indexPath.row])
            sheets.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}
