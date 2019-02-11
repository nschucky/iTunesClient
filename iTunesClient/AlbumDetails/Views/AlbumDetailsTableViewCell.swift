//
//  AlbumDetailsTableViewCell.swift
//  iTunesClient
//
//  Created by Alves Jorge on 15/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import UIKit

class AlbumDetailsTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: AlbumDetailsTableViewCell.self)
    
    let songNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let trackTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = NSTextAlignment.right
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupCell() {
        addSubview(songNameLabel)
        addSubview(trackTimeLabel)
        songNameLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 5), size: CGSize.zero)
        trackTimeLabel.anchor(top: topAnchor, leading: songNameLabel.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 5, left: 15, bottom: 5, right: 15), size: CGSize.zero)
    }
    
    func configure(with viewModel: SongViewModel) {
        songNameLabel.text = viewModel.title
        trackTimeLabel.text = viewModel.runtime
    }
    
}
