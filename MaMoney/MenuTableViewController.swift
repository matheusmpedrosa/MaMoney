//
//  MenuTableViewController.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 09/02/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    var viewTitle: String

    var sheets: [Sheet] = [
        Sheet().getMoneyInSheetMock(),
        Sheet().getMoneyOutSheetMock(),
        Sheet().getLeftOverSheetMock(),
        Sheet().getRegularExpensesSheetMock()
    ]
    
    init(viewTitle: String) {
        self.viewTitle = viewTitle
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
        tableView.register(SheetTableViewCell.self, forCellReuseIdentifier: "sheetCell")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sheets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sheetCell", for: indexPath) as? SheetTableViewCell else {
            fatalError("Could not dequeue SheetTableViewCell.")
        }
        cell.setup(sheet: sheets[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sheet = sheets[indexPath.row]
        let sheetTableViewController = SheetTableViewController(sheet: sheet)
        navigationController?.pushViewController(sheetTableViewController, animated: true)
    }
}
