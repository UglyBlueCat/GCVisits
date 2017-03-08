//
//  NetworkManager.swift
//  GCVisits
//
//  Created by Robin Spinks on 05/03/2017.
//  Copyright © 2017 Robin Spinks. All rights reserved.
//

import Foundation

class NetworkManager {
    
    let defaultSession : URLSession
    
    /*
     * Create a shared instance to initialise class as a singleton so there's only one URLSession
     * originally taken from: http://krakendev.io/blog/the-right-way-to-write-a-singleton
     */
    static let sharedInstance = NetworkManager()
    fileprivate init() {
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 300.0
        
        self.defaultSession = URLSession(configuration: configuration)
    }
    
    /**
     Handles an HTTP request of any type
     
     - parameters:
     - request: The HTTP request
     - completion: A method to handle the returned data
     */
    func handleRequest (request: URLRequest, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        
        let task : URLSessionDataTask = defaultSession.dataTask(with: request, completionHandler: completion)
        task.resume()
    }
    
}
