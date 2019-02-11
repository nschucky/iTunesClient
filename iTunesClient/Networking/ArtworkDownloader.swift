//
//  ArtworkDownloader.swift
//  iTunesClient
//
//  Created by Alves Jorge on 16/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import Foundation
import UIKit

class ArtworkDownloader: Operation {
    let album: Album
    
    init(album: Album) {
        self.album = album
    }
    
    override func main() {
        
        if isCancelled { return }
        
        guard let url = URL(string: album.artworkUrl) else { return }
        print(url.absoluteString)
        guard let imageData = try? Data(contentsOf: url) else {
            print("error downloading contents of image")
            return
        }
        
        if isCancelled { return }
        
        if imageData.count > 0 {
            album.artwork = UIImage(data: imageData)
            album.artworkState = .downloaded
        } else {
            album.artworkState = .failed
        }
    }
}
