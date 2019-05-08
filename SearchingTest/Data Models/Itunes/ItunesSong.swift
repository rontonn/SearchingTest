//
//  ItunesSong.swift
//  SearchingTest
//
//  Created by Anton Romanov on 07/05/2019.
//  Copyright © 2019 Anton Romanov. All rights reserved.
//

import Foundation

struct ItunesSong: Codable {
    // MARK: - Properties
    var artistName: String
    var trackName: String?
    var trackImage: String
}

// MARK: - Extensions
extension ItunesSong {
    private enum CodingKeys : String, CodingKey {
        case artistName
        case trackName
        case trackImage = "artworkUrl100"
    }
}
