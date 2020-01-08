//
//  ImageView.swift
//  NDXTunes
//
//  Created by RajanAR21 on 1/7/20.
//  Copyright © 2020 RajanAR21. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    //download image async
    func setImage(from url: URL, withPlaceholder placeholder: UIImage? = nil) {
        self.image = placeholder
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
            }.resume()
    }
}

