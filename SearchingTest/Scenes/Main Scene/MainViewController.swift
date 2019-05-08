//
//  MainViewController.swift
//  SearchingTest
//
//  Created by Anton Romanov on 07/05/2019.
//  Copyright © 2019 Anton Romanov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet var searchResultsTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var segmentControl: UISegmentedControl!
    
    // MARK: - Properties
    let viewModel = MainViewModel()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        addBindings()
        
    }
    
    // MARK: - Public methods
    func addBindings() {
        viewModel.iTunesResults.bind { [unowned self] results in
            if results?.resultCount == 0 {
                self.presentAlert(withTitle: "No songs were found.", andMessage: "There is no mathes for what you are looking for. Try something else.")
            }
            DispatchQueue.main.async { [unowned self] in
                self.searchResultsTableView.reloadData()
            }
            
        }
        
        viewModel.lastFmResults.bind { [unowned self] results in
            if results?.results.opensearchTotalResults == "0" {
                self.presentAlert(withTitle: "No songs were found.", andMessage: "There is no mathes for what you are looking for. Try something else.")
            }
            DispatchQueue.main.async { [unowned self] in
                self.searchResultsTableView.reloadData()
            }
            
        }
        
        viewModel.error.bind { (error) in
            if let message = error?.localizedDescription {
                self.presentAlert(withTitle: "Error!", andMessage: message)
            }
            
        }
    }
    
    @objc func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    // MARK: - IBActions
    @IBAction func segmentSwitchedAction(_ sender: UISegmentedControl) {
        
        viewModel.changeSource(withTag: sender.selectedSegmentIndex)
    }
    
    // MARK: - Private methods
    private func presentAlert(withTitle title: String, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }

}

// MARK: - TableViewDelegate and DataSource
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let totalCount = viewModel.totalCount {
            return totalCount
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as! SearchResultCell
        
        viewModel.getTrackInfo(for: indexPath)
        
        if let urlString = viewModel.trackImageURL {
            if let url = URL(string: urlString) {
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        cell.imageOfTheSong.image = UIImage(data: data!)
                    }
                }
            } else {
                cell.imageOfTheSong.image = UIImage()
            }
        }
        
        cell.lblArtistName.text = viewModel.artistName
        cell.lblSongName.text = viewModel.trackName
        
        return cell
    }
}

// MARK: - SearchbarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            if !searchText.isEmpty {
                viewModel.updateSearchedText(with: searchText)
                dismissKeyboard()
                
            } else {
                presentAlert(withTitle: "Empty request.", andMessage: "Please, type song name ot artist name to perform searching.")
            }
        }
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.clearOldData()
        searchBar.text = ""
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dismissKeyboard()
    }
}
