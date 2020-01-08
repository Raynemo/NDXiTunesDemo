//
//  AlbumCustomCell.swift
//  NDXTunes
//
//  Created by RajanAR21 on 1/7/20.
//  Copyright © 2020 RajanAR21. All rights reserved.
//

import Foundation


import UIKit
import NDXDataModel

class AlbumCell : UITableViewCell {
    
    let attributeMenlo12 = [ NSAttributedString.Key.font: UIFont(name: "Menlo", size: 12.0)! ]
    let attributeMenlo16 = [ NSAttributedString.Key.font: UIFont(name: "Menlo", size: 16.0)! ]
    
    var album : AlbumsResult? {
        didSet {
            albumNameLabel.attributedText = NSAttributedString(string: album?.name ?? "", attributes: attributeMenlo16)
            artistNameLabel.attributedText = NSAttributedString(string: album?.artistName ?? "", attributes: attributeMenlo12)
            if let url = URL(string: album?.artworkUrl100 ?? "") {
                iconImage.setImage(from: url, withPlaceholder: UIImage(named: "albumPlaceHolder.jpg") )
            } else {
                iconImage.image = UIImage(named: "albumPlaceHolder.jpg")
            }
        }
    }
    
    private let albumNameLabel : UILabel = {
        let lbl = UILabel(frame: CGRect(x: 110, y: 0, width: 400, height: 40))
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.contentMode = .scaleToFill
        lbl.backgroundColor = .white
        return lbl
    }()
    
    
    private let artistNameLabel : UILabel = {
        let lbl = UILabel(frame: CGRect(x: 110, y: 50, width: 400, height: 40))
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.contentMode = .scaleToFill
        lbl.backgroundColor = .white
        return lbl
    }()
    
    private let refreshButton : UIButton = {
        let btn = UIButton(type: .custom)
      //  btn.setImage(#imageLiteral(resourceName: "minusTb"), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFill
        return btn
    }()

    private let iconImage : UIImageView = {
        let imgView = UIImageView()
        imgView.frame = CGRect(x: 0, y: 0, width: 72, height: 72)
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.backgroundColor = .clear
        return imgView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "cellId")
        addSubview(albumNameLabel)
        addSubview(artistNameLabel)
        addSubview(iconImage)
        setupAutoLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAutoLayout() {
        
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false

        let iconImageWidthConstraint = iconImage.widthAnchor.constraint(equalToConstant: 72)
        let iconImageHeightConstraint = iconImage.widthAnchor.constraint(equalToConstant: 72)
        addConstraints([iconImageWidthConstraint, iconImageHeightConstraint])
        
        iconImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 32).isActive = true
        iconImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true

        albumNameLabel.leftAnchor.constraint(equalTo: iconImage.rightAnchor, constant: 20).isActive = true
        albumNameLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        albumNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true

        artistNameLabel.leftAnchor.constraint(equalTo: iconImage.rightAnchor, constant: 20).isActive = true
        artistNameLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        artistNameLabel.topAnchor.constraint(equalTo: albumNameLabel.bottomAnchor, constant: 20).isActive = true
    }
}
