//
//  SearchResult.swift
//  iTunes Search
//
//  Created by Samantha Gatt on 8/7/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    let title: String
    let creator: String
    
    enum CodingKeys: String, CodingKey {
        case title = "trackName"
        case creator = "artistName"
    }
}

struct SearchResults: Codable {
    let results: [SearchResult]
}
