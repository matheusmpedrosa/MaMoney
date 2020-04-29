//
//  AdddNewItemViewController.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 23/03/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import UIKit

class AdddNewItemViewController: UIViewController {

    fileprivate var formView = AddNewItemFormView(frame: .zero)
    
    fileprivate var commomConstraints: [NSLayoutConstraint] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = formView
        formView.delegate = self
        hideKeyboardWhenTappedAround()
    }
}

extension AdddNewItemViewController: DidTapSaveButtonProtocol {
    func didTapSaveButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
