//
//  extensions.swift
//  YoutubeClone
//
//  Created by woong on 18/01/2019.
//  Copyright © 2019 woong. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        
        // [v[index]: UIView]
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()

class CustomImageView: UIImageView {
    
    var imageUrlString: String?
    
    func loadImageUsingUrlString(urlString: String) {
        
        imageUrlString = urlString
        
        guard let url = URL(string: urlString) else { return }
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            DispatchQueue.main.async {
                if let data = data {
                    guard let imageToCache = UIImage(data: data) else { return }
                    
                    if self.imageUrlString == urlString {
                        imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
                        self.image = imageToCache
                    }
                }
            }
            
            }.resume()
    }
}


//extension UIImageView {
//
//    func loadImageUsingUrlString(urlString: String) {
//        guard let url = URL(string: urlString) else { return }
//
//        image = nil
//
//        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
//            self.image = imageFromCache
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//
//            DispatchQueue.main.async {
//                if let data = data {
//                    guard let imageToCache = UIImage(data: data) else { return }
//
//                    imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
//                    self.image = imageToCache
//
//                }
//            }
//
//            }.resume()
//    }
//}
