//
//  AlbumsTableViewController.swift
//  iTunesClient
//
//  Created by Alves Jorge on 15/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import UIKit

protocol AlbumsDelegate: class {
    func selectedAlbum(_ album: Album)
}

class AlbumsTableViewController: UITableViewController {

    var artist: Artist?
    lazy var dataSource: AlbumsDataSource = {
        return AlbumsDataSource(data: [], tableView: self.tableView)
    }()
    
    weak var delegate: AlbumsDelegate?
    let client: ItunesAPIClient
    
    init(client: ItunesAPIClient) {
        self.client = client
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: AlbumTableViewCell.identifier)
        tableView.dataSource = dataSource
        guard let artist = artist else { return }
        client.lookup(withId: artist.id) { [weak self] (artistResult, error) in
            print("chamando aqi")
            guard let self = self else { return }
            guard let artistResult = artistResult else { return}
            self.dataSource.update(with: artistResult.albums)
            self.tableView.reloadData()
        }
    }

}

extension AlbumsTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        let albumSelected = dataSource.albumSelected(at: indexPath.row)
        print("songs", albumSelected.songs)
        delegate?.selectedAlbum(albumSelected)
        
    }
}
