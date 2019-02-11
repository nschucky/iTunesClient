//
//  PendingOperations.swift
//  iTunesClient
//
//  Created by Alves Jorge on 16/01/19.
//  Copyright © 2019 Alves Jorge. All rights reserved.
//

import Foundation


class PendingOperations {
    var downloadsInProgress = [IndexPath: Operation]()
    let downloadQueue = OperationQueue()
}
