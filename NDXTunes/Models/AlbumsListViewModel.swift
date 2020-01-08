//
//  AlbumsListViewModel.swift
//  NDXTunes
//
//  Created by RajanAR21 on 1/6/20.
//  Copyright © 2020 RajanAR21. All rights reserved.
//

import Foundation
import NDXNetwork
import NDXDataModel

protocol AlbumsListViewModelDelegate: class {
    func didReceiveData(data: Feed)
    func errorReceivingData(error: String)
}

class AlbumsListViewModel {
    
    weak var delegate: AlbumsListViewModelDelegate?
    init() {
        
    }
    
    func loadData() {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/explicit.json"
        NetworkManager.sharedInstance.getRSSFeed(urlString: urlString) { result in
            switch result {
            case .success(let response):
                self.delegate?.didReceiveData(data: response.feed)
            case .failure(let error):
                self.delegate?.errorReceivingData(error: error.localizedDescription)
            }
        }
    }
}
