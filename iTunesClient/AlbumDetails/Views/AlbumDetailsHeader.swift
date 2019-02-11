//
//  AlbumDetailsHeader.swift
//  iTunesClient
//
//  Created by Alves Jorge on 15/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import UIKit

class AlbumDetailsHeader: UITableViewHeaderFooterView {
    
    static let identifier = String(describing: AlbumDetailsHeader.self)
    
    let coverImageView: UIImageView = {
        let iv = UIImageView()
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
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupHeader()
    }

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupHeader() {
        addSubview(coverImageView)
        coverImageView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets.zero, size: CGSize(width: 100, height: 100))
        
        
        let stackView = UIStackView(arrangedSubviews: [albumNameLabel, genreLabel, releaseDataLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .leading
        addSubview(stackView)
        
        stackView.anchor(top: topAnchor, leading: coverImageView.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 10), size: CGSize.zero)
    }
    
    func configureHeader(with viewModel: DetailHeaderViewModel) {
        albumNameLabel.text = viewModel.title
        genreLabel.text = viewModel.genre
        releaseDataLabel.text = viewModel.releaseDate
    }
    
}
