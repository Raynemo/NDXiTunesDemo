//
//  AlbumViewController.swift
//  NDXTunes
//
//  Created by RajanAR21 on 1/6/20.
//  Copyright © 2020 RajanAR21. All rights reserved.
//

import UIKit
import SafariServices

class AlbumViewController: UIViewController, SFSafariViewControllerDelegate {
    
    var viewModel: AlbumViewModel = AlbumViewModel()
    var safariVC: SFSafariViewController?

    let scrollView = UIScrollView()
    let stackView = UIStackView()
    
    //label items to display album details
    private let albumNameLabel : UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 40))
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .center
        lbl.contentMode = .scaleToFill
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.backgroundColor = .white
        return lbl
    }()
    
    private let artistNameLabel : UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 50, width: 400, height: 40))
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.contentMode = .scaleToFill
        lbl.backgroundColor = .white
        return lbl
    }()
    
    private let genreLabel : UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 400, height: 40))
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        lbl.contentMode = .scaleToFill
        lbl.textAlignment = .center
        lbl.backgroundColor = .white
        return lbl
    }()
    
    private let releaseDateLabel : UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 50, width: 400, height: 40))
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.backgroundColor = .white
        return lbl
    }()
    
    private let copyRightLabel : UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 50, width: 400, height: 40))
        lbl.textColor = .black
        lbl.font = UIFont.systemFont(ofSize: 16)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.backgroundColor = .white
        return lbl
    }()
    
    
    //button to visit iTunes album page
    private let previewButton : UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 50, width: 200, height: 60)
        btn.backgroundColor = .blue
        btn.layer.cornerRadius = 12.0
        return btn
    }()
    
    private let iconImage : UIImageView = {
        let imgView = UIImageView()
        imgView.frame = CGRect(x: 60, y: 60, width: 200, height: 200)
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.backgroundColor = .white
        return imgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        populateFields()
        setupAutoLayout()
    }
    
    func populateFields() {
        
        if let url = URL(string: viewModel.currentAlbum?.artworkUrl100 ?? "") {
            iconImage.setImage(from: url, withPlaceholder: UIImage(named: "albumPlaceHolder.jpg") )
        }
        
        let attributeMenlo22 = [ NSAttributedString.Key.font: UIFont(name: "Menlo", size: 22.0)! ]
        let attributeMenlo16 = [ NSAttributedString.Key.font: UIFont(name: "Menlo", size: 16.0)! ]
        let attributeMenlo12 = [ NSAttributedString.Key.font: UIFont(name: "Menlo", size: 12.0)! ]

        albumNameLabel.attributedText = NSAttributedString(string: viewModel.currentAlbum?.name ?? "", attributes: attributeMenlo22)
        artistNameLabel.attributedText = NSAttributedString(string: viewModel.currentAlbum?.artistName ?? "", attributes: attributeMenlo22)
        copyRightLabel.attributedText = NSAttributedString(string: viewModel.currentAlbum?.copyright ?? "", attributes: attributeMenlo12)
        
        //format release data
        if let input = viewModel.currentAlbum?.releaseDate {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy-MM-dd"
            if let date = formatter.date(from: String(input.prefix(10))) {
                let reformatter = DateFormatter()
                reformatter.dateStyle = .long
                let dateString = reformatter.string(from: date)
                releaseDateLabel.attributedText = NSAttributedString(string: dateString, attributes: attributeMenlo16)  //dateString
            }
        }
        //show multiple generes separated by comma
        if viewModel.currentAlbum?.genres.count ?? 0 > 0 {
            let genres = viewModel.currentAlbum?.genres.map({ $0.name })
            let genresList = genres?.joined(separator: ", ")
            genreLabel.attributedText = NSAttributedString(string: genresList ?? "", attributes: attributeMenlo16)
        }
    }

    func setupAutoLayout() {
        //define height constraints
        let iconImageHeightConstraint = iconImage.heightAnchor.constraint(equalToConstant: 200)
        let albumNameLabelHeightConstraint = albumNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20)
        let releaseDateLabelHeightConstraint = releaseDateLabel.heightAnchor.constraint(equalToConstant: 20)
        let copyRightLabelHeightConstraint = copyRightLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20)
        let artistNameLabelHeightConstraint = artistNameLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 20)
        
        view.addConstraints([iconImageHeightConstraint,
                             albumNameLabelHeightConstraint,
                             releaseDateLabelHeightConstraint,
                             copyRightLabelHeightConstraint,
                             artistNameLabelHeightConstraint])

        //position button anchored to bottom
        previewButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20).isActive = true
        previewButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        previewButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    
    //launch iTunes store and redirect to album page
    @objc
    func goToStore() {
        if let albumName = viewModel.currentAlbum?.name, let albumId = viewModel.currentAlbum?.id {
            let correctedPath2 = albumName.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlPathAllowed)
            guard let correctedPath = correctedPath2 else {
                return
            }

            let collectionViewUrl = "https://music.apple.com/us/album/\(correctedPath)/\(albumId)?app=music"
            guard let url = URL(string: String(collectionViewUrl)) else {
                return
            }
            
            safariVC = SFSafariViewController(url: url)
            safariVC?.delegate = self
            if let svc = safariVC {
                present(svc, animated: true, completion: nil)
            }
        }
    }
    
    //not called?
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func setupUI() {
        
        navigationItem.title = viewModel.currentAlbum?.name
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        //constrain scroll view
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        
        //add and setup stack view
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        
        //constrain stack view to scroll view
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -80).isActive = true
        stackView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -40).isActive = true
        
        //turn off auto resize
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistNameLabel.translatesAutoresizingMaskIntoConstraints = false
        genreLabel.translatesAutoresizingMaskIntoConstraints = false
        releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        copyRightLabel.translatesAutoresizingMaskIntoConstraints = false
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        previewButton.translatesAutoresizingMaskIntoConstraints = false

        //add views to stack
        stackView.addArrangedSubview(iconImage)
        stackView.addArrangedSubview(albumNameLabel)
        stackView.addArrangedSubview(artistNameLabel)
        stackView.addArrangedSubview(genreLabel)
        stackView.addArrangedSubview(releaseDateLabel)
        stackView.addArrangedSubview(copyRightLabel)
        
        view.addSubview(previewButton)
        
        //set text for button at bottom
        var attributes = [NSAttributedString.Key: AnyObject]()
        attributes[.foregroundColor] = UIColor.white
        attributes[.font] = UIFont(name: "Menlo", size: 16.0)
        previewButton.setAttributedTitle(NSAttributedString(string: "View iTunes", attributes: attributes), for: .normal)
        previewButton.addTarget(self, action: #selector(goToStore), for: .touchUpInside)
        view.bringSubviewToFront(previewButton)
    }
}
