//
//  AlbumsDataSource.swift
//  iTunesClient
//
//  Created by Alves Jorge on 15/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import UIKit

class AlbumsDataSource: NSObject, UITableViewDataSource {
    
    private var data: [Album]
    let tableView: UITableView
    let pendingOperations = PendingOperations()
    
    init(data: [Album], tableView: UITableView) {
        self.data = data
        self.tableView = tableView
        super.init()
    }
    
    func albumSelected(at index: Int) -> Album {
        return data[index]
    }
    
    func update(with data: [Album]) {
        self.data = data
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.identifier, for: indexPath) as? AlbumTableViewCell else {
             return UITableViewCell()
        }
        let album = data[indexPath.row]
        let albumViewModel = AlbumViewModel(album: album)
        cell.configure(with: albumViewModel)
        cell.accessoryType = .disclosureIndicator
        if album.artworkState == .placeholder {
            downloadArtwork(forAlbum: album, atIndexPath: indexPath)
        }
        return cell
    }
    
    func downloadArtwork(forAlbum album: Album, atIndexPath indexPath: IndexPath) {
        if let _ = pendingOperations.downloadsInProgress[indexPath] {
            return
        }
        let downloader = ArtworkDownloader(album: album)
        downloader.completionBlock = {
            if downloader.isCancelled { return }
            DispatchQueue.main.async {
                self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        
        pendingOperations.downloadsInProgress[indexPath] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
    }
}
