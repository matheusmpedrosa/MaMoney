//
//  TabBarViewController.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 22/02/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    private var sheet: Sheet
    
    init(sheet: Sheet) {
        self.sheet = sheet
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = sheet.title
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        setTabBarItems()
    }
    
    private func setTabBarItems() {
        guard let tables = sheet.table.allObjects as? [Table] else { return }
        let tablesViewController = TablesViewController(tables: tables)
        let tablesTabBarItem = UITabBarItem(title: "Tabelas", image: #imageLiteral(resourceName: "icn-list"), selectedImage: #imageLiteral(resourceName: "icn-list"))
        tablesViewController.tabBarItem = tablesTabBarItem
        
        let graphsViewController = GraphsViewController()
        let graphsTabBarItem = UITabBarItem(title: "Gráficos", image: #imageLiteral(resourceName: "icn-chart"), selectedImage: #imageLiteral(resourceName: "icn-chart"))
        graphsViewController.tabBarItem = graphsTabBarItem
        
        self.viewControllers = [tablesViewController, graphsViewController]
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")
    }
}
