//
//  JSONDownloader.swift
//  iTunesClient
//
//  Created by Alves Jorge on 16/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import Foundation

enum ItunesError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure(String)
}

class JSONDownloader {
    let session: URLSession
    
    init(sessionConfiguration: URLSessionConfiguration) {
        session = URLSession(configuration: sessionConfiguration)
    }
    
    convenience init() {
        self.init(sessionConfiguration: .default)
    }
    
    typealias JSON = [String: Any]
    typealias JSONTaskCompletionHandler = (JSON?, ItunesError?) -> Void
    
    func jsonTask(with request: URLRequest, completion: @escaping JSONTaskCompletionHandler) -> URLSessionTask {
        let task = session.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        completion(json, nil)
                    } catch {
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
        return task
    }
}
