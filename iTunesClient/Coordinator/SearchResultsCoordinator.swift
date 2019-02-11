//
//  SearchResultsCoordinator.swift
//  iTunesClient
//
//  Created by Alves Jorge on 15/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import UIKit

class SearchResultsCoordinator: Coordinator, SearchResultsDelegate {
    private let presenter: UIWindow
    private let navigationController: UINavigationController
    private let searchResultsController: SearchReultsController
    private var albumsCoordinator: AlbumsCoordinator?
    let client: ItunesAPIClient
    
    init(presenter: UIWindow, client: ItunesAPIClient) {
        self.presenter = presenter
        self.client = client
        searchResultsController = SearchReultsController(client: client)
        navigationController = UINavigationController(rootViewController: searchResultsController)
    }
    
    func start() {
        guard let mainViewController = presenter.rootViewController else { return }
        searchResultsController.delegate = self
        searchResultsController.title = "Itunes Search"
        mainViewController.present(navigationController, animated: true, completion: nil)

    }
    
    func artistSelected(_ artist: Artist) {
        let albumsCoordinator = AlbumsCoordinator(presenter: navigationController, artist: artist, client: client)
        albumsCoordinator.start()
        self.albumsCoordinator = albumsCoordinator
        
    }
}
