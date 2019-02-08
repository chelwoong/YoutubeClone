//
//  ApiService.swift
//  YoutubeClone
//
//  Created by woong on 07/02/2019.
//  Copyright © 2019 woong. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    
    static let sharedInstance = ApiService()
    
    let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets/"
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        fetchFeedForString(urlString: "\(baseUrl)home.json", completion: completion)
    }
    
    func fetchTrendingFeed(completion: @escaping ([Video]) -> ()) {
        fetchFeedForString(urlString: "\(baseUrl)trending.json", completion: completion)
    }
    
    func fetchSubscriptionFeed(completion: @escaping ([Video]) -> ()) {
        fetchFeedForString(urlString: "\(baseUrl)subscriptions.json", completion: completion)
    }
    
    func fetchFeedForString(urlString: String, completion: @escaping ([Video]) -> ()) {
        // set up URL request
        guard let url = URL(string:urlString) else {
            print("Error: cannot create URL")
            return
        }
        
        // set up Session
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let dataTask: URLSessionDataTask = session.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print("dataTask Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                
                let decoder = JSONDecoder()
                let videos = try decoder.decode([Video].self, from: data)
                
                DispatchQueue.main.async {
                    completion(videos)
                }
                
                
                
            } catch(let err) {
                print(err.localizedDescription)
            }
            
        }
        dataTask.resume()
        
    }
}
