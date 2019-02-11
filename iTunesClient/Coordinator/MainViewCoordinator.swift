//
//  MainViewCoordinator.swift
//  iTunesClient
//
//  Created by Alves Jorge on 15/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
}

class MainViewCoordinator: Coordinator, ViewControllerDelegate {
    
    
    let presenter: UIWindow
    var mainViewController: ViewController?
    var searchResultsCoordinator: SearchResultsCoordinator?
    let client: ItunesAPIClient
    
    init(presenter: UIWindow, client: ItunesAPIClient) {
        self.presenter = presenter
        self.client = client
    }
    
    func start() {
        
        let mainViewController = ViewController()
        mainViewController.delegate = self
        presenter.rootViewController = mainViewController
        presenter.makeKeyAndVisible()
        
        self.mainViewController = mainViewController
    }
    
    func showResults() {
        let searchResultsCoodinator = SearchResultsCoordinator(presenter: presenter, client: client)
        searchResultsCoodinator.start()
        self.searchResultsCoordinator = searchResultsCoodinator
    }
    
    
}

