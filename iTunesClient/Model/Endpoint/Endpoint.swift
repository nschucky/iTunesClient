//
//  Endpoint.swift
//  iTunesClient
//
//  Created by Alves Jorge on 16/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
    
}

extension Endpoint {
    var urlCompoenets: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = queryItems
        return components
    }
    
    var request: URLRequest {
        let url = urlCompoenets.url!
        let request = URLRequest(url: url)
        return request
    }
}

enum Itunes {
    case search(term: String, mediaType: ItunesMedia?)
    case lookup(id: Int, entity: ItunesEntity?)
}


extension Itunes: Endpoint {
    var base: String {
        return "https://itunes.apple.com"
    }
    
    var path: String {
        switch self {
        case .search: return "/search"
        case .lookup: return "/lookup"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .search(let term, let mediaType):
            var result = [URLQueryItem]()
            let searchTerm = URLQueryItem(name: "term", value: term)
            result.append(searchTerm)
            
            if let media = mediaType {
                let mediaItem = URLQueryItem(name: "media", value: media.description)
                result.append(mediaItem)
                
                if let item = media.entityQueryItem {
                    result.append(item)
                }
                
                if let attributeQueryItem = media.attributeQueryItem {
                    result.append(attributeQueryItem)
                }
            }

            
            return result
        case .lookup(let id, let entity):
             return [
                URLQueryItem(name: "id", value: id.description),
                URLQueryItem(name: "entity", value: entity?.entityName)
            ]
        }
        
    }
}
