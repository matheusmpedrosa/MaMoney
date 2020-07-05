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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = formView
        formView.titleTextFieldDidChangeValueDelegate = self
        formView.switchDidChangeValueDelegate = self
        formView.stepperDidChangeValueDelegate = self
        formView.valueTextFieldDidChangeValueDelegate = self
        formView.dateTextFieldDidChangeValueDelegate = self
        formView.didTapSaveButtonDelegate = self
        hideKeyboardWhenTappedAround()
    }
}

extension AdddNewItemViewController: TitleTextFieldDidChangeValueProtocol {
    func titleTextFieldDidChangeValue(title: String) {
        print("🦠 titleTextFieldDidChangeValue")
    }
}

extension AdddNewItemViewController: SwitchDidChangeValueProtocol {
    func switchDidChangeValue(_ isOn: Bool) {
        print("🦠 switchDidChangeValue")
    }
}

extension AdddNewItemViewController: StepperDidChangeValueProtocol {
    func stepperDidChangeValue(_ count: Double) {
        print("🦠 stepperDidChangeValue")
    }
}

extension AdddNewItemViewController: ValueTextFieldDidChangeValueProtocol {
    func ValueTextFieldDidChangeValue(_ value: Decimal) {
        print("🦠 ValueTextFieldDidChangeValue")
    }
}

extension AdddNewItemViewController: DateTextFieldDidChangeValueProtocol {
    func dateTextFieldDidChangeValue(_ date: Date) {
        print("🦠 dateTextFieldDidChangeValue")
    }
}

extension AdddNewItemViewController: SaveButtonWasTappedProtocol {
    func saveButtonWasTapped() {
        //save Item model
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
