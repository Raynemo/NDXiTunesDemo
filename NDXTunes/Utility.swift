//
//  Utility.swift
//  NDXTunes
//
//  Created by RajanAR21 on 1/6/20.
//  Copyright © 2020 RajanAR21. All rights reserved.
//

import Foundation
import UIKit


public class Utility {
    
    static func createTable(cellId: String) -> UITableView {
        let tv = UITableView(frame: CGRect(x: 100, y: 100, width: 200, height: 200), style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .lightGray
        tv.register(AlbumCell.self, forCellReuseIdentifier: cellId)
        return tv
    }
    
    static func createLabel(cellId: String) -> UILabel {
        let lbl = UILabel(frame: .zero)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }
    
    static func createTextView() -> UITextView {
        let txtVu = UITextView(frame: .zero)
        txtVu.translatesAutoresizingMaskIntoConstraints = false
        return txtVu
    }
}
