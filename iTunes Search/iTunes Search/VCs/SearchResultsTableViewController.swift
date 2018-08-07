//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Samantha Gatt on 8/7/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController, UISearchBarDelegate {

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultCell", for: indexPath)

        let searchResult = searchResults[indexPath.row]
        cell.textLabel?.text = searchResult.title
        cell.detailTextLabel?.text = searchResult.creator

        return cell
    }
    
    // MARK: - SearchBarDelegate
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text else { return }
        // Instructions said to make it a type ResultType! but I left off the ! because I didn't see why it was needed and it made .software etc not work
        var resultType: ResultType
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        default:
            resultType = .movie
        }
        
        searchResultController.performSearch(for: searchTerm, resultType: resultType) { (searchResults, error) -> NSError? in
            
            if let error = error {
                NSLog("Error performing search: \(error)")
                return NSError()
            }
            
            self.searchResults = searchResults ?? []
            return nil
        }
    }
    
    
    // MARK: - Properties
    
    let searchResultController = SearchResultController()
    var searchResults = [SearchResult]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
}
