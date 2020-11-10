//
//  RRUIImageView+Extension.swift
//  PeopleCarousel
//
//  Created by Rahul Mayani on 15/10/20.
//

import UIKit
import Kingfisher
import RxSwift

extension UIImageView {
        
    func setKingfisherImageView(image: String?, placeholder: String = "placeholder") {
        var path = /*AWSBucket.bucketPath +*/ (image ?? "")
        if let url = image, url.isValidURL() {
            path = url
        }
                
        if placeholder.isEmpty {
            self.kf.indicatorType = .activity
            let indicator = self.kf.indicator?.view as? UIActivityIndicatorView
            //indicator?.style = .whiteLarge
            indicator?.color = UIColor.blue
        }
        
        self.kf.setImage(
            with: URL(string: path),
            placeholder: UIImage(named: placeholder),
            options: [
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
    }
}
