//
//  GraphsViewController.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 22/02/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import UIKit

class GraphsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Graphs"
        setupViewUI()
    }
    
    private func setupViewUI() {
        self.view.backgroundColor = .systemBackground
        self.navigationController?.navigationBar.backgroundColor = .systemBackground
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
