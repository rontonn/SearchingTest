//
//  LastFmSong.swift
//  SearchingTest
//
//  Created by Anton Romanov on 07/05/2019.
//  Copyright © 2019 Anton Romanov. All rights reserved.
//

import Foundation

// MARK: - Structure 'LastFmSong'
struct LastFmSong: Codable {
    // MARK: Properties
    var trackName: String
    var artistName: String
    var trackImage: [Image]
}

// MARK: - Extensions
extension LastFmSong {
    private enum CodingKeys : String, CodingKey {
        case trackName = "name"
        case artistName = "artist"
        case trackImage = "image"
    }
    
    enum Size: String, Codable {
        case extralarge = "extralarge"
        case large = "large"
        case medium = "medium"
        case small = "small"
    }
    
    // MARK: Structure 'Image'
    struct Image: Codable {
        let text: String
        let size: Size
        
        enum CodingKeys: String, CodingKey {
            case text = "#text"
            case size
        }
    }
}
