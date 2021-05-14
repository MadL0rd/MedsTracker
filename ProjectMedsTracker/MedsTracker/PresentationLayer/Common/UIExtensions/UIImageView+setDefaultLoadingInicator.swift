//
//  UIImageView+setDefaultLoadingInicator.swift
//  ClubhouseAvatarMaker
//
//  Created by Anton Tekutov on 14.05.21.
//

import SDWebImage
import UIKit

extension UIImageView {
    
    func setDefaultLoadingInicator() {
        sd_imageIndicator = SDWebImageActivityIndicator.gray
    }
}
