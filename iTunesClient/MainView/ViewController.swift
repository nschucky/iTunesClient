//
//  ViewController.swift
//  iTunesClient
//
//  Created by Alves Jorge on 14/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import UIKit

protocol ViewControllerDelegate: class {
    func showResults()
}

class ViewController: UIViewController {
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search on Itunes", for: .normal)
        button.addTarget(self, action: #selector(showSearchResultsController), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: ViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        let searchEndpoint = Itunes.search(term: "taylor Swift", mediaType: .music(entity: .musicArtist, attribute: .artistTerm))
        print(searchEndpoint.request)
    }
    
    fileprivate func setupView() {
        view.backgroundColor = .white
        view.addSubview(button)
        button.centerInSuperview()
    }
    
    @objc fileprivate func showSearchResultsController() {
        delegate?.showResults()
    }


}

