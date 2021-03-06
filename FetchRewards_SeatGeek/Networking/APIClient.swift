//
//  APIClient.swift
//  FetchRewards_SeatGeek
//
//  Created by Alan Longcoy on 3/6/21.
//

import Foundation


// Create a class for the API Client to connecto to https://api.seatgeek.com

class APIClient
{
    // Initial downloader for JSON data
    let downloader = JSONDownloader()
    
    // Function to get a generic call of events
    
    func getEvents(completion: @escaping (Events?, String?) -> Void)
    {
        
        let clientID = "MjE1NzYxOTl8MTYxNTAxMjM4MC41NjIwNzA0"
        let endpoint = "https://api.seatgeek.com/2/events?client_id=" + clientID
        
        performRequest(with: endpoint)
        {
            results, error in
            
            
            guard let results = results else
            {
                completion(nil, error)
                return
            }
            
            let events = Events(json: results)
            
            completion(events, nil)
            
        }
 
    }
    
    // Function to get events based on search value
    
    func getSearch(searchTerm: String, completion: @escaping (Events?, String?) -> Void)
    {
        
        let clientID = "MjE1NzYxOTl8MTYxNTAxMjM4MC41NjIwNzA0"
        let endpoint = "https://api.seatgeek.com/2/events?q=\(searchTerm)&client_id=" + clientID
        
        performRequest(with: endpoint)
        {
            results, error in
            
            
            guard let results = results else
            {
                completion(nil, error)
                return
            }
            
            let events = Events(json: results)
            
            completion(events, nil)
            
        }
 
    }
    
    typealias Results = [[String: Any]]
    
    private func performRequest(with endpoint: String, completion: @escaping (Results?, String?) -> Void)
    {
        
        let task = downloader.jsonTask(with: URLRequest(url: URL(string: endpoint)!))
        {
            json, error in
            
            DispatchQueue.main.async
            {
                    guard let json = json else
                    {
                        completion(nil, "json error")
                        return
                    }
                    
                    guard let results = json["events"] as? [[String: Any]] else
                    {
                        completion([], "parse failure")
                        return
                    }
                    
                    completion(results, nil)
            }
            
        }
        
        task.resume()
        
    }
}
