//
//  SearchResultController.swift
//  iTunes Search
//
//  Created by Samantha Gatt on 8/7/18.
//  Copyright © 2018 Samantha Gatt. All rights reserved.
//

import Foundation

class SearchResultController {
    
    // MARK: - Properties
    var searchResults: [SearchResult] = []
    
    // MARK: - Base URL
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    // MARK: - Search Function
    // "Result of call is unused, but produces NSError()"
    func performSearch(for searchTerm: String, resultType: ResultType, completion: @escaping ([SearchResult]?, Error?) -> Void) {
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        let searchQueryItem =  URLQueryItem(name: "term", value: searchTerm)
        urlComponents.queryItems = [searchQueryItem]
        
        guard let requestURL = urlComponents.url else {
            NSLog("Error constructing search URL for \(searchTerm)")
            completion(nil, NSError())
            return
        }
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = "GET"
        
        // MARK: Data Task
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                NSLog("Error performing data task: \(error)")
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                NSLog("Error retrieving data. No data returned")
                completion(nil, NSError())
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let decodedResults = try jsonDecoder.decode(SearchResults.self, from: data)
                let searchResults = decodedResults.results.filter { $0.resultType == resultType.rawValue }
                completion(searchResults, nil)
            } catch {
                NSLog("Error decoding data: \(error)")
                completion(nil, error)
                return
            }
        }.resume()
    }
}
