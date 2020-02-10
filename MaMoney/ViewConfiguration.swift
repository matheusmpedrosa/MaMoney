//
//  ViewConfiguration.swift
//  MaMoney
//
//  Created by Matheus Pedrosa on 09/02/20.
//  Copyright © 2020 Matheus Pedrosa. All rights reserved.
//

import Foundation

protocol ViewConfiguration: class {
    func configureView()
    func buildViewHierarchy()
    func setupConstraints()
}

extension ViewConfiguration {
    func configureView() {
        buildViewHierarchy()
        setupConstraints()
    }
}
