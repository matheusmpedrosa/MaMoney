//
//  AddNewTableViewController.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 18/05/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import UIKit

protocol DidDismissViewControllerDelegate: AnyObject {
    func didDismissViewController()
}

class AddNewTableViewController: UIViewController {
    
    fileprivate var formView = AddNewTableFormView(frame: .zero)
    fileprivate var tableTitle: String = ""
    fileprivate var tableColorName: String = ""
    weak var dismissDelegate: DidDismissViewControllerDelegate?
    
    fileprivate var dataManager: TableDataManager
    
    init(dataManager: TableDataManager, dismissDelegate: DidDismissViewControllerDelegate?) {
        self.dataManager = dataManager
        self.dismissDelegate = dismissDelegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = formView
        formView.didTapSaveButtonDelegate = self
        formView.titleTextFieldDidChangeValueDelegate = self
        formView.didSelectTableColorDelegate = self
        hideKeyboardWhenTappedAround()
    }
    
}

extension AddNewTableViewController: TitleTextFieldDidChangeValueProtocol {
    func titleTextFieldDidChangeValue(title: String) {
        self.tableTitle = title
    }
}

extension AddNewTableViewController: DidSelectTableColorDelegate {
    func didSelectTableColor(color: String?) {
        if let color = color {
            self.tableColorName = color
        }
    }
}

extension AddNewTableViewController: SaveButtonWasTappedProtocol {
    func saveButtonWasTapped() {
        let newTable = Table(context: dataManager.getContext())
        newTable.title = tableTitle
        newTable.color = tableColorName
        dataManager.insert(object: newTable)
        self.dismiss(animated: true) {
            self.dismissDelegate?.didDismissViewController()
        }
    }
}
