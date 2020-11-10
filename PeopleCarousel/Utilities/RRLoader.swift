//
//  RRLoader.swift
//  PeopleCarousel
//
//  Created by Rahul Mayani on 15/10/20.
//

import NVActivityIndicatorView
import UIKit

private let vLoader = UIView()

private let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(0, 0, 50, 50), type: .ballRotateChase, color: UIColor.blue, padding: CGFloat(0))
//private let activityIndicatorView = UIActivityIndicatorView.init(style: .whiteLarge)

struct RRLoader {
    
    static func startLoaderToAnimating(_ isMask: Bool = true)  {
        
        DispatchQueue.main.async {
            if isMask {
                vLoader.frame = UIScreen.main.bounds
                vLoader.backgroundColor = UIColor.black.withAlphaComponent(0.2)
                appDelegate.window?.addSubview(vLoader)
            }
            
            //activityIndicatorView.color = R.color.themeColor()
            //activityIndicatorView.hidesWhenStopped = true
            activityIndicatorView.center = CGPoint(x: UIScreen.main.bounds.size.width*0.5, y: UIScreen.main.bounds.size.height*0.5)
            appDelegate.window?.addSubview(activityIndicatorView)
            
            activityIndicatorView.startAnimating()
        }
    }
    
    static func stopLoaderToAnimating() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            activityIndicatorView.stopAnimating()
            vLoader.removeFromSuperview()
        }
    }
}
