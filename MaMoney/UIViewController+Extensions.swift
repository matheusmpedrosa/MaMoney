//
//  UIViewController+Extensions.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 09/02/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc
    func dismissKeyboard() {
        view.endEditing(true)
    }

    func presentAlertWithOptions(title: String?, message: String?, style: UIAlertController.Style, options: String..., completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)

        for (index, option) in options.enumerated() {
            let action = UIAlertAction(title: option, style: .default, handler: { (_) in
                completion(index)
            })

            let image = UIImage(named: options[index].lowercased())
            let imageView = UIImageView()
            imageView.image = image
            imageView.frame = CGRect(x: 25, y: 18, width: 24, height: 24)

            if options[index] == "Cancelar" {
                alertController.addAction(UIAlertAction(title: "Cancelar", style: .destructive, handler: nil))
            } else {
                action.setValue(imageView.image, forKey: "image")
                alertController.addAction(action)
            }
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
