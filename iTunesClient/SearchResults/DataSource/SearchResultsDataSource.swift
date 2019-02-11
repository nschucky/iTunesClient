//
//  SearchResultsDataSource.swift
//  iTunesClient
//
//  Created by Alves Jorge on 15/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import UIKit

class SearchResultsDataSource: NSObject, UITableViewDataSource {
    
    private var data = [Artist]()
    
    override init() {
        super.init()
    }
    
    func updateWith(_ artists: [Artist]) {
        data = artists
    }
    
    func artistSelected(at index: Int) -> Artist {
        return data[index]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ResultsTableViewCell.identifier, for: indexPath) as? ResultsTableViewCell else {
            return UITableViewCell()
        }
        cell.artistNameLabel.text = data[indexPath.row].name
        return cell
    }
    
}
