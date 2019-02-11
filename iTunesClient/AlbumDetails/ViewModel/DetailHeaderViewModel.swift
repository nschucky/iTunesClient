//
//  DetailHeaderViewModel.swift
//  iTunesClient
//
//  Created by Alves Jorge on 15/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import Foundation


struct DetailHeaderViewModel {
    let title: String
    let releaseDate: String
    let genre: String
}

extension DetailHeaderViewModel {
    
    init(album: Album) {
        self.title = album.name
        self.genre = album.primaryGenre.name
        
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = .medium
        
        self.releaseDate = formatter.string(from: album.releaseDate)
    }
    
}
