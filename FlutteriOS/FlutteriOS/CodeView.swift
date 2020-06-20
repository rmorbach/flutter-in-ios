//
//  CodeView.swift
//  FlutteriOS
//
//  Created by Rodrigo Morbach on 20/06/20.
//  Copyright © 2020 Morbach Inc. All rights reserved.
//

import Foundation

protocol CodeView {
    
    func setup()
    func setupConstraints()
    func setupComponents()
    func setupExtraConfigurations()
    
}

extension CodeView {
    func setup() {
        setupComponents()
        setupConstraints()
        setupExtraConfigurations()
    }
}
