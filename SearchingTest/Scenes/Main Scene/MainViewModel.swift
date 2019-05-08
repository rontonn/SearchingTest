//
//  MainViewModel.swift
//  SearchingTest
//
//  Created by Anton Romanov on 07/05/2019.
//  Copyright © 2019 Anton Romanov. All rights reserved.
//

import Foundation

class MainViewModel {
    // MARK: - Properties
    let iTunesResults: Box<ItunesResults?> = Box(nil)
    let lastFmResults: Box<LastFmResults?> = Box(nil)
    let error: Box<Error?> = Box(nil)
    
    var searchedText = ""
    
    var trackName: String?
    var artistName: String?
    var trackImageURL: String?
    var totalCount: Int? {
        switch selectedSource {
            
        case .iTunes:
            return iTunesResults.value?.resultCount
        case .LastFm:
            let itemsPerPage = Int(lastFmResults.value?.results.opensearchItemsPerPage ?? "0")
            
            if let totalResults = lastFmResults.value?.results.opensearchTotalResults {
                if let totalValue = Int(totalResults) {
                    if totalValue == 0 {
                        return 0
                        
                    } else if let itemsCount = itemsPerPage, totalValue > itemsCount {
                        
                        return itemsCount
                    } else {
                        
                        return totalValue
                    }
                }
                
            }
            
            return 0
        }
    }
    
    private var selectedSource: Source = .iTunes
    
    // MARK: - Public methods
    func updateSearchedText(with text: String) {
        searchedText = text
        performSongSearching(forText: searchedText)
    }
    
    func changeSource(withTag tag: Int) {
        
        switch tag {
        case 0:
            selectedSource = .iTunes
        default:
            selectedSource = .LastFm
        }
        
        performSongSearching(forText: searchedText)
    }
    
    func getTrackInfo(for indexPath: IndexPath) {
        switch selectedSource {
            
        case .iTunes:
            trackName = iTunesResults.value?.results[indexPath.row].trackName
            artistName = iTunesResults.value?.results[indexPath.row].artistName
            trackImageURL = iTunesResults.value?.results[indexPath.row].trackImage
            
        case .LastFm:
            trackName = lastFmResults.value?.results.trackmatches.foundTracks[indexPath.row].trackName
            artistName = lastFmResults.value?.results.trackmatches.foundTracks[indexPath.row].artistName
            /*
             trackImage[0] is small image
             trackImage[1] is medium image
             trackImage[2] is large image
             trackImage[3] is extralarges image
            */
            trackImageURL = lastFmResults.value?.results.trackmatches.foundTracks[indexPath.row].trackImage[1].text
        }
    }
    
    func clearOldData() {
        iTunesResults.value = nil
        lastFmResults.value = nil
    }
    
    // MARK: - Private methods
    private func performSongSearching(forText searchText: String) {
        clearOldData()
        var searchRequest = ""
        
        switch selectedSource {
        case .iTunes:
            searchRequest = searchText + "&limit=200"
            NetworkManager.request(forSource: selectedSource, with: searchRequest) { [unowned self] (result: Result<ItunesResults, Error>) in
                
                switch result {
                    
                case .success(let itunesResults):
                    self.iTunesResults.value = itunesResults
                    
                case .failure(let error):
                    self.error.value = error
                }
            }
            
        case .LastFm:
            searchRequest = "?method=track.search&track=\(searchText)&limit=200&api_key=98d171503cc74b1736404710fa1fab12&format=json"
            NetworkManager.request(forSource: selectedSource, with: searchRequest) { [unowned self] (result: Result<LastFmResults, Error>) in
                
                switch result {
                    
                case .success(let lastFmResults):
                    self.lastFmResults.value = lastFmResults
                    
                case .failure(let error):
                    self.error.value = error
                }
            }
        }
        
        
    }
}
