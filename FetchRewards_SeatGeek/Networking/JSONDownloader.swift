//
//  JSONDownloader.swift
//  FetchRewards_SeatGeek
//
//  Created by Alan Longcoy on 3/6/21.
//

import Foundation

// Downloader that will create the task and make api call
class JSONDownloader
{
    let session: URLSession
    
    init(configuration: URLSessionConfiguration)
    {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init()
    {
        self.init(configuration: .default)
    }
    
    typealias JSON = [String: AnyObject]
    typealias JSONTaskCompletionHandler = (JSON?, String?) -> Void
    
    func jsonTask(with request: URLRequest, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask
    {
        let task = session.dataTask(with: request)
        {
            data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else
            {
                completion(nil, "Request Failed")
                return
            }
            
            if (httpResponse.statusCode == 200)
            {
                
                if let data = data
                {
                    do
                    {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject]
                        completion(json, nil)
                    }
                    catch
                    {
                        completion(nil, "JSON Conversion failure")
                    }
                }
                else
                {
                    completion(nil, "Invalid Data")
                }
            }
            
        }
        
        return task
        
    }
}
