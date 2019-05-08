//
//  ItunesResults.swift
//  SearchingTest
//
//  Created by Anton Romanov on 07/05/2019.
//  Copyright © 2019 Anton Romanov. All rights reserved.
//

import Foundation

struct ItunesResults: Codable {
    // MARK: - Properties
    let resultCount: Int
    let results: [ItunesSong]
}
