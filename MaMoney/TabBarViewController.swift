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
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        self.title = sheet.title
        
        let tablesViewController = TablesViewController(viewTitle: sheet.title, tables: sheet.tables)
        let tablesTabBarItem = UITabBarItem(title: "Tables", image: #imageLiteral(resourceName: "list"), selectedImage: #imageLiteral(resourceName: "list"))
        tablesViewController.tabBarItem = tablesTabBarItem
        
        let graphsViewController = GraphsViewController()
        let graphsTabBarItem = UITabBarItem(title: "Graphs", image: #imageLiteral(resourceName: "chart"), selectedImage: #imageLiteral(resourceName: "chart"))
        graphsViewController.tabBarItem = graphsTabBarItem
        
        self.viewControllers = [tablesViewController, graphsViewController]
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("Selected \(viewController.title!)")
    }
}
