//
//  ItunesAPIClient.swift
//  iTunesClient
//
//  Created by Alves Jorge on 16/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import Foundation


class ItunesAPIClient {
    
    let downloader = JSONDownloader()
    
    func searchForArtist(with term: String, completion: @escaping ([Artist], Error?) -> ()) {
        let endpoint = Itunes.search(term: term, mediaType: .music(entity: .musicArtist, attribute: .artistTerm))
        performRequet(withEndpoint: endpoint) { (results, error) in
            guard let results = results else {
                completion([], error)
                return
            }
            
            let artists = results.compactMap { Artist(json: $0) }
            completion(artists, nil)
            
        }
        
    }
    
    func lookup(withId id: Int, completion: @escaping (Artist?, ItunesError?) -> ()) {
        let endpoint = Itunes.lookup(id: id, entity: MusicEntity.album)
        
        performRequet(withEndpoint: endpoint) { (results, error) in
            guard let results = results else {
                completion(nil, error)
                return
            }
            
            guard let artistInfo = results.first else {
                completion(nil, .jsonParsingFailure("Results does not contain artist info"))
                return
            }
            
            guard let artist = Artist(json: artistInfo) else {
                completion(nil, .jsonParsingFailure("Could not parse artist info"))
                return
            }
            
            let albumsResults = results[1..<results.count]
            artist.albums = albumsResults.compactMap { Album(json: $0) }            
            
            completion(artist, nil)
            
            
            
        }
    }
    
    typealias Results = [[String: Any]]
    
    func lookupAlbum(withId id: Int, completion: @escaping (Album?, ItunesError?) -> ()) {
        let endpoint = Itunes.lookup(id: id, entity: MusicEntity.song)
        
        performRequet(withEndpoint: endpoint) { (results, error) in
            
            DispatchQueue.main.async {
                guard let results = results else {
                    completion(nil, error)
                    return
                }
                
                
                guard let albumInfo = results.first else {
                    completion(nil, .jsonParsingFailure("Results does not contain album information"))
                    return
                }
                
                guard let album = Album(json: albumInfo) else {
                    completion(nil, .jsonParsingFailure("Could not parse album information"))
                    return
                }
                
                let songsResults = results[1..<results.count]
                album.songs = songsResults.compactMap { Song(json: $0) }
                
                completion(album, nil)
            }
            
        }
    }
    
    
    
    fileprivate func performRequet(withEndpoint endpoint: Endpoint, completion: @escaping (Results?, ItunesError?) -> ()) {
        
        let task = downloader.jsonTask(with: endpoint.request) { (json, error) in
            
            DispatchQueue.main.async {
                guard let json = json else {
                    completion([], error)
                    return
                }
                
                guard let result = json["results"] as? Results else {
                    completion([], ItunesError.jsonParsingFailure("JSON data does not contain results"))
                    return
                }
                
                completion(result, nil)
            }
            
        }
        
        task.resume()
    }
    
}
