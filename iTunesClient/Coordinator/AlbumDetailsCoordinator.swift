//
//  AlbumDetailsCoordinator.swift
//  iTunesClient
//
//  Created by Alves Jorge on 15/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import UIKit


class AlbumDetailsCoordinator: Coordinator {
    
    let presenter: UINavigationController
    let album: Album
    let client: ItunesAPIClient
    
    init(presenter: UINavigationController, album: Album, client: ItunesAPIClient) {
        self.presenter = presenter
        self.album = album
        self.client = client
    }
    
    func start() {
        let albumDetailsController = AlbumsDetailsTableViewController(client: client)
        albumDetailsController.album = album
        presenter.pushViewController(albumDetailsController, animated: true)
    }
}
