//
//  ViewController.swift
//  NDXTunes
//
//  Created by RajanAR21 on 1/6/20.
//  Copyright © 2020 RajanAR21. All rights reserved.
//

import UIKit
import NDXDataModel
import NDXNetwork

class AlbumListViewController: UIViewController {

    private let cellId = "cellId"
    private var tableView: UITableView = UITableView()
    private var reloadButton: UIButton?
    private var viewModel: AlbumsListViewModel?
    
    var albumsList: [AlbumsResult] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupAutoLayout()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel = AlbumsListViewModel()
        viewModel?.delegate = self
        viewModel?.loadData()

    }

    func setupUI() {
        //create table
        tableView = Utility.createTable(cellId: cellId)
        view.addSubview(tableView)
        navigationItem.title = "Top 100 Albums"
    }
    
    func setupAutoLayout() {
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension AlbumListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AlbumCell
        cell.album = albumsList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let celldata = albumsList[indexPath.row]
        let avc:AlbumViewController = AlbumViewController()
        avc.viewModel.currentAlbum = celldata
        navigationController?.show(avc, sender: nil)
    }
}

extension AlbumListViewController: AlbumsListViewModelDelegate {
    func errorReceivingData(error: String) {
        print(error)
    }
    
    func didReceiveData(data: Feed) {
        albumsList = data.results
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
