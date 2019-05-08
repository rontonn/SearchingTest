//
//  SearchResultCell.swift
//  SearchingTest
//
//  Created by Anton Romanov on 07/05/2019.
//  Copyright © 2019 Anton Romanov. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet var imageOfTheSong: UIImageView!
    @IBOutlet var lblSongName: UILabel!
    @IBOutlet var lblArtistName: UILabel!
    
    // MARK: - Life cycle
    override func prepareForReuse() {
        imageOfTheSong.image = nil
        lblSongName.text = ""
        lblArtistName.text = ""
    }
}
