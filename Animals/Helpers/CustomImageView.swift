//
//  CustomImageView.swift
//  Animals
//
//  Created by Kevin Rojas on 1/11/18.
//  Copyright © 2018 Kevin. All rights reserved.
//

import UIKit

var imageCache = NSCache<NSString, AnyObject>()

class CustomImageView: UIImageView {
    var imageUrlString : String?
    
    func loadImageUsingUrlString(urlString: String) {
        image = UIImage(named: "LaunchScreen")
        
        imageUrlString = urlString
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) as? UIImage {
            image = imageFromCache
            return
        }
        
        let url = NSURL(string: urlString)
        
        URLSession.shared.dataTask(with: url! as URL, completionHandler: { (data, response, error) in
            if error != nil { return }
            
            DispatchQueue.main.async(execute: {
                let imageToCache = UIImage(data: data!)
                
                if self.imageUrlString == urlString {
                    self.image = imageToCache
                }
                
                imageCache.setObject(imageToCache!, forKey: urlString as NSString)
            })
        }).resume()
    }
}
