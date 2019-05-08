//
//  Source.swift
//  SearchingTest
//
//  Created by Anton Romanov on 07/05/2019.
//  Copyright © 2019 Anton Romanov. All rights reserved.
//

import Foundation

enum Source {
    // MARK: - Properties
    case iTunes
    case LastFm
    
    var baseURL: String {
        switch self {
        case .iTunes:
            return "https://itunes.apple.com/search?term="
        case .LastFm:
            return "http://ws.audioscrobbler.com/2.0/"
        }
    }
}
