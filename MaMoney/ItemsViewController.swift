//
//  ItemsViewController.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 09/02/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import UIKit

public enum HeightConstants: CGFloat {
    case kPortraitBottomSafeAreaHeight = 34.0
    case kPortraitTopSafeAreaHeight = 44.0
    case kLandscapeBottomSafeAreaHeight = 21.0
    case kFooterViewAccessibilityHeight = 120.0
    case kFooterViewHeight = 40.0
}

class ItemsViewController: UIViewController {
    
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        return tableView
    }()

    fileprivate var viewTitle: String
    fileprivate var table: Table
    fileprivate var footerView = TotalAmountView(frame: .zero)
    
    fileprivate var commomConstraints: [NSLayoutConstraint] = []
    
    init(table: Table) {
        self.viewTitle = table.title
        self.table = table
        let total = table.totalAmount?.toBrazilianRealString()
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.navigationBar.tintColor = .systemBlue
    }
    
    private func setupViewUI() {
        self.title = viewTitle
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = table.color
        self.navigationController?.navigationBar.backgroundColor = .systemBackground
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItem))
        self.tableView.tableFooterView = UIView()
    }
    
    private func registerCell() {
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: String(describing: ItemTableViewCell.self))
    }
    
    @objc
    private func addItem() {
        let addNewItemViewController = AdddNewItemViewController()
        addNewItemViewController.modalPresentationStyle = .pageSheet
        self.present(addNewItemViewController, animated: true, completion: nil)
    }
}
    
extension ItemsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return table.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ItemTableViewCell.self),
                                                       for: indexPath) as? ItemTableViewCell else {
            fatalError("Could not dequeue ItemTableViewCell.")
        }
        cell.setup(item: table.items[indexPath.row])
        return cell
    }
}

extension ItemsViewController: ViewConfiguration {
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
            
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        updateLayoutConstraints()
    }
    
    func updateLayoutConstraints() {
        NSLayoutConstraint.activate(commomConstraints)
    }
}
