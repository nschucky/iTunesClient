//
//  AlbumTableViewCell.swift
//  iTunesClient
//
//  Created by Alves Jorge on 15/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: AlbumTableViewCell.self)
    
    let coverImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .cyan
        iv.image = #imageLiteral(resourceName: "AlbumPlaceholder")
        return iv
    }()

    let albumNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Album name"
        return label
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.text = "Genre"
        return label
    }()
    
    let releaseDataLabel: UILabel = {
        let label = UILabel()
        label.text = "Jan 01, 2002"
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
        addSubview(coverImageView)
        coverImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 10, left: 15, bottom: 0, right: 0), size: CGSize(width: 80, height: 80))
        
        let stackView = UIStackView(arrangedSubviews: [albumNameLabel, genreLabel, releaseDataLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        addSubview(stackView)
        
        stackView.anchor(top: topAnchor, leading: coverImageView.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 10), size: CGSize.zero)
        
    }
    
    func configure(with viewModel: AlbumViewModel) {
        coverImageView.image = viewModel.artworkImage
        albumNameLabel.text = viewModel.title
        genreLabel.text = viewModel.genre
        releaseDataLabel.text = viewModel.releaseDate
    }

}
