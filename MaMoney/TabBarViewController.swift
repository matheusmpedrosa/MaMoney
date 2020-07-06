//
//  TabBarViewController.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 22/02/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    private var sheet: Sheet?
    private var dataManager: TableDataManager
    private var tablesViewController: TablesViewController?
    
    
    init(sheet: Sheet, dataManager: TableDataManager) {
        self.sheet = sheet
        self.dataManager = dataManager
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        self.title = sheet?.title
        setTabBarItems()
        appendRightBarButtonItems()
    }
    
    private func appendRightBarButtonItems() {
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTable))
        let editBarButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editCurrentTable))
        self.navigationItem.rightBarButtonItems = [addBarButton, editBarButton]
    }
    
    private func removeRightBarButtonItems() {
        self.navigationItem.rightBarButtonItems = []
    }
    
    @objc
    private func addNewTable() {
        guard let sheet = sheet else { return }
        let addNewTableViewController = AddNewTableViewController(sheet: sheet, dataManager: dataManager, dismissDelegate: self.tablesViewController!)
        self.present(addNewTableViewController, animated: true, completion: nil)
    }
    
    @objc
    private func editCurrentTable() {
        //store.edit()
    }
    
    private func setTabBarItems() {
        guard let sheet = sheet else { return }
        guard let tables = sheet.table.allObjects as? [Table] else { return }
        self.tablesViewController = TablesViewController(sheet: sheet, tables: tables, dataManager: dataManager)
        let tablesTabBarItem = UITabBarItem(title: "Tabelas", image: #imageLiteral(resourceName: "icn-list"), selectedImage: #imageLiteral(resourceName: "icn-list"))
        tablesViewController!.tabBarItem = tablesTabBarItem
        
        let graphsViewController = GraphsViewController()
        let graphsTabBarItem = UITabBarItem(title: "Gráficos", image: #imageLiteral(resourceName: "icn-chart"), selectedImage: #imageLiteral(resourceName: "icn-chart"))
        graphsViewController.tabBarItem = graphsTabBarItem
        
        self.viewControllers = [tablesViewController!, graphsViewController]
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController is GraphsViewController {
            removeRightBarButtonItems()
        } else {
            appendRightBarButtonItems()
        }
    }
}
