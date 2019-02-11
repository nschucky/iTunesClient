//
//  AlbumsCoordinator.swift
//  iTunesClient
//
//  Created by Alves Jorge on 15/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import UIKit

class AlbumsCoordinator: Coordinator, AlbumsDelegate {
    
    
    
    let presenter: UINavigationController
    let artist: Artist
    let client: ItunesAPIClient
    var albumsController: AlbumsTableViewController?
    var albumsDetailsCoordinator: AlbumDetailsCoordinator?
    
    init(presenter: UINavigationController, artist: Artist, client: ItunesAPIClient) {
        self.presenter = presenter
        self.artist = artist
        self.client = client
    }
    
    func start() {
        let albumsController = AlbumsTableViewController(client: client)
        albumsController.delegate = self
        albumsController.title = artist.name
        albumsController.artist = artist
        presenter.pushViewController(albumsController, animated: true)
        self.albumsController = albumsController
    }
    
    func selectedAlbum(_ album: Album) {
        let albumDetailsCoordinator = AlbumDetailsCoordinator(presenter: presenter, album: album, client: client)
        albumDetailsCoordinator.start()
    }
    
    
}
