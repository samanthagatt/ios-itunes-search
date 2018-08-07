//
//  SearchResultsTableViewController.swift
//  iTunes Search
//
//  Created by Samantha Gatt on 8/7/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        

        return cell
    }
    
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var searchBar: UISearchBar!
}
