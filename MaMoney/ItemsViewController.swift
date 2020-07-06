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

    fileprivate var table: Table
    fileprivate var footerView = TotalAmountView(frame: .zero)
    
    fileprivate var commomConstraints: [NSLayoutConstraint] = []
    
    init(table: Table) {
        self.table = table
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
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.tintColor = .systemBlue
    }
    
    private func setupViewUI() {
        self.title = table.title
        self.footerView.setup(total: computeTotalAmount().toBrazilianRealString())
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.tintColor = table.color.colorFromString()
        self.navigationController?.navigationBar.backgroundColor = .systemBackground
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewItem))
        self.tableView.tableFooterView = UIView()
    }
    
    private func registerCell() {
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: String(describing: ItemTableViewCell.self))
    }
    
    private func computeTotalAmount() -> Decimal {
        var amount: Decimal = 0.0
        let items = table.item.allObjects as? [Item]
        if let items = items {
            for item in items {
                amount += item.value.decimalValue
            }
        }
        return amount
    }
    
    @objc
    private func addNewItem() {
        let addNewItemViewController = AdddNewItemViewController()
        self.present(addNewItemViewController, animated: true, completion: nil)
    }
}
    
extension ItemsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return table.item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ItemTableViewCell.self),
                                                       for: indexPath) as? ItemTableViewCell else {
            fatalError("Could not dequeue ItemTableViewCell.")
        }
        let item = table.item.allObjects[indexPath.row] as! Item
        cell.setup(item: item)
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
