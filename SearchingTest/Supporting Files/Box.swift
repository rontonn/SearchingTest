//
//  Box.swift
//  SearchingTest
//
//  Created by Anton Romanov on 07/05/2019.
//  Copyright © 2019 Anton Romanov. All rights reserved.
//

import Foundation

class Box<T> {
    typealias Listener = (T) -> Void
    
    // MARK: - Properties
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    // MARK: - Life cycle
    init(_ value: T) {
        self.value = value
    }
    
    // MARK: - Public methods
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
