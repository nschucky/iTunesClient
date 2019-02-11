//
//  AlbumDetailsDataSource.swift
//  iTunesClient
//
//  Created by Alves Jorge on 15/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import UIKit

class AlbumDetailsDataSource: NSObject, UITableViewDataSource {
    
    private var data: [Song]
    
    init(data: [Song]) {
        self.data = data
        super.init()
    }
    
    func update(with data: [Song]) {
        self.data = data
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumDetailsTableViewCell.identifier, for: indexPath) as? AlbumDetailsTableViewCell else {
            return UITableViewCell()
        }
        let songViewModel = SongViewModel(song: data[indexPath.row])
        cell.configure(with: songViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            print("returning tracks")
            return "Tracks"
        default: return nil
        }
    }
    
    
    func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return 0
    }

    
    
    

    

}
