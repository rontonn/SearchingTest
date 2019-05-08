//
//  LastFmResults.swift
//  SearchingTest
//
//  Created by Anton Romanov on 07/05/2019.
//  Copyright © 2019 Anton Romanov. All rights reserved.
//

import Foundation

// MARK: - Structure 'LastFmResults'
struct LastFmResults: Codable {
    // MARK: Properties
    let results: Results
}

// MARK: - Structure 'Results'
struct Results: Codable {
    // MARK: Properties
    let opensearchQuery: OpensearchQuery
    let opensearchTotalResults, opensearchStartIndex, opensearchItemsPerPage: String
    let trackmatches: Trackmatches
    
    enum CodingKeys: String, CodingKey {
        case opensearchQuery = "opensearch:Query"
        case opensearchTotalResults = "opensearch:totalResults"
        case opensearchStartIndex = "opensearch:startIndex"
        case opensearchItemsPerPage = "opensearch:itemsPerPage"
        case trackmatches
    }
}

// MARK: - Structure 'OpensearchQuery'
struct OpensearchQuery: Codable {
    // MARK: Properties
    let text, role, startPage: String
    
    enum CodingKeys: String, CodingKey {
        case text = "#text"
        case role, startPage
    }
}

// MARK: - Structure 'Trackmatches'
struct Trackmatches: Codable {
    // MARK: Properties
    let foundTracks: [LastFmSong]
    
    enum CodingKeys: String, CodingKey {
        case foundTracks = "track"
    }
}
