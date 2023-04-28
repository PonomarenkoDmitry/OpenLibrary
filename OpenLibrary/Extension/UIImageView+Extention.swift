//
//  UIImageView+Extention.swift
//  OpenLibrary
//
//  Created by Дмитрий Пономаренко on 28.04.23.
//

import UIKit
import Kingfisher


extension UIImageView {
    
    func setImage(with urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        let resourse = ImageResource(downloadURL: url, cacheKey: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: resourse)
    }
    
}
