//
//  SheetsViewController.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 20/02/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import UIKit
import CoreData

class SheetsViewController: UIViewController {
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    var sheetCount: Int = 1

    fileprivate var sheets: [Sheet] = []
    fileprivate var dataManager: SheetDataManager
    fileprivate var emptyStateView = EmptyStateView(frame: .zero)
    
    fileprivate var commomConstraints: [NSLayoutConstraint] = []
    
    init(dataManager: SheetDataManager) {
        self.dataManager = dataManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkForFirstLaunch()
        setupViewUI()
        registerCell()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupViewUI() {
        title = "Planilhas"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewSheet))
        emptyStateView.setup(type: .sheet, delegate: self)
        tableView.tableFooterView = UIView()
    }
    
    private func checkForFirstLaunch() {
        let firstLaunch = FirstLaunch(userDefaults: .standard, key: "FirstLaunch")
        if firstLaunch.isFirstLaunch {
            dataManager.insertSampleSheet()
        }
        fetchSheets()
    }
    
    private func registerCell() {
        tableView.register(SheetTableViewCell.self, forCellReuseIdentifier: String(describing: SheetTableViewCell.self))
    }
    
    private func fetchSheets() {
        dataManager.fetchAll { [weak self] (sheets) in
            if let sheets = sheets as? [Sheet] {
                self?.sheets = sheets
            } else {
                self?.sheets = []
            }
            self?.tableView.reloadData()
        }
        
        if self.sheets.isEmpty {
            UIView.transition(with: emptyStateView, duration: 0.3, options: .curveEaseInOut, animations: {
                self.emptyStateView.alpha = 1
            }, completion: nil)
        } else {
            UIView.transition(with: emptyStateView, duration: 0.3, options: .curveEaseInOut, animations: {
                self.emptyStateView.alpha = 0
            }, completion: nil)
        }
    }
    
    @objc
    private func addNewSheet() {
        dataManager.insert(object: dataManager.createNewSheet(number: sheetCount))
        sheetCount += 1
        fetchSheets()
    }

}

extension SheetsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sheets.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SheetTableViewCell.self),
                                                       for: indexPath) as? SheetTableViewCell else {
            fatalError("Could not dequeue TableTableViewCell.")
        }
        cell.setup(sheet: sheets[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            dataManager.delete(object: sheets[indexPath.row])
            sheets.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            fetchSheets()
        }
    }

}

extension SheetsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sheet = sheets[indexPath.row]
        let tableDataManager = TableDataManager(context: dataManager.getContext())
        let tabBarViewController = TabBarViewController(sheet: sheet, dataManager: tableDataManager)
        navigationController?.pushViewController(tabBarViewController, animated: true)
    }

}

extension SheetsViewController: AddButtonWasTappedProtocol {
    func addButtonWasTapped() {
        dataManager.insert(object: dataManager.createNewSheet(number: sheetCount))
        sheetCount += 1
        fetchSheets()
    }
}

extension SheetsViewController: ViewConfiguration {
    func buildViewHierarchy() {
        view.addSubview(tableView)
        view.addSubview(emptyStateView)
    }
    
    func setupConstraints() {
        commomConstraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor),
            
            emptyStateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            emptyStateView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            emptyStateView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            emptyStateView.bottomAnchor.constraint(equalTo:  view.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        updateLayoutConstraints()
    }
    
    func updateLayoutConstraints() {
        NSLayoutConstraint.activate(commomConstraints)
    }
}
