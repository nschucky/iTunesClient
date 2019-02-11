//
//  AlbumsDetailsTableViewController.swift
//  iTunesClient
//
//  Created by Alves Jorge on 15/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import UIKit

class AlbumsDetailsTableViewController: UITableViewController {
    
    var album: Album?
    let client: ItunesAPIClient
    
    init(client: ItunesAPIClient) {
        self.client = client
        super.init(style: .grouped)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    var dataSource = AlbumDetailsDataSource(data: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(AlbumDetailsTableViewCell.self, forCellReuseIdentifier: AlbumDetailsTableViewCell.identifier)
        tableView.register(AlbumDetailsHeader.self, forHeaderFooterViewReuseIdentifier: AlbumDetailsHeader.identifier)
        tableView.dataSource = dataSource
        
        guard let album = album else { return }
        client.lookupAlbum(withId: album.id) { [weak self] (albumResult, error) in
            guard let self = self else { return }
            if let albumResult = albumResult {
                self.dataSource.update(with: albumResult.songs)
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: AlbumDetailsHeader.identifier) as? AlbumDetailsHeader else { return nil }
        if let album = album {
            header.configureHeader(with: DetailHeaderViewModel(album: album))
        }
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 100
    }
    
}
