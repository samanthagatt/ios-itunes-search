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
        search()
    }
    
    
    // MARK: - Actions
    
    @IBAction func changeSegment(_ sender: Any) {
        search()
    }
    
    
    // MARK: - Functions
    
    func search() {
        guard let searchTerm = searchBar.text else { return }
        var resultType: ResultType
        
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            resultType = .software
        case 1:
            resultType = .musicTrack
        default:
            resultType = .movie
        }
        
        searchResultController.performSearch(for: searchTerm, resultType: resultType) { (searchResults, error) -> Void in
            
            if let error = error {
                NSLog("Error performing search: \(error)")
                return
            }
            
            self.searchResults = searchResults ?? []
            return
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
