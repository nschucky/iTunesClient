
//
//  AlbumViewModel.swift
//  iTunesClient
//
//  Created by Alves Jorge on 15/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import Foundation
import UIKit

struct AlbumViewModel {
    
    let title: String
    let releaseDate: String
    let genre: String
    let artworkImage: UIImage
    
}

extension AlbumViewModel {
    
    init(album: Album) {
        
        artworkImage = album.artworkState == .downloaded ? album.artwork! : #imageLiteral(resourceName: "AlbumPlaceholder")
        
        self.title = album.name
        self.genre = album.primaryGenre.name
        
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = .medium
        
        self.releaseDate = formatter.string(from: album.releaseDate)
    }
    
}
