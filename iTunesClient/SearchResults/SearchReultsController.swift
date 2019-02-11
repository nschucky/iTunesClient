//
//  SearchReultsController.swift
//  iTunesClient
//
//  Created by Alves Jorge on 15/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import UIKit

protocol SearchResultsDelegate: class {
    func artistSelected(_ artist: Artist)
}


class SearchReultsController: UITableViewController {
    
    let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.dimsBackgroundDuringPresentation = false
        
        return searchController
    }()
    
    let dataSource = SearchResultsDataSource()
    weak var delegate: SearchResultsDelegate?
    let client: ItunesAPIClient
    
    init(client: ItunesAPIClient) {
        self.client = client
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(dismissSearchResults))
        tableView.dataSource = dataSource
        tableView.register(ResultsTableViewCell.self, forCellReuseIdentifier: ResultsTableViewCell.identifier)
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
    }
    
    
    @objc fileprivate func dismissSearchResults() {
        dismiss(animated: true, completion: nil)
    }

}

extension SearchReultsController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, searchText.count > 0 {
            client.searchForArtist(with: searchController.searchBar.text!) { [weak self] (artist, error) in
                guard let self = self else { return }
                self.dataSource.updateWith(artist)
                self.tableView.reloadData()
            }
        } else {
            self.tableView.reloadData()
        }
        
    }
}

extension SearchReultsController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let artist = dataSource.artistSelected(at: indexPath.row)
        print(artist.name)
        delegate?.artistSelected(artist)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
