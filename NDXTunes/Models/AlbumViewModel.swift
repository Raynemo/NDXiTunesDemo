//
//  AlbumViewModel.swift
//  NDXTunes
//
//  Created by RajanAR21 on 1/6/20.
//  Copyright © 2020 RajanAR21. All rights reserved.
//

import Foundation
import NDXNetwork
import NDXDataModel

class AlbumViewModel {
    var currentAlbum: AlbumsResult?
    init(album: AlbumsResult? = nil) {
        currentAlbum = album
    }
}

