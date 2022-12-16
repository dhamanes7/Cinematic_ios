//
//  CustomImageView.swift
//  Cinematic
//
//  Created by Gurpreet Kaur on 2022-12-15.
//
import Foundation
import UIKit
let imageCache = NSCache<NSString, UIImage>()
class CustomImageView: UIImageView {
    private var imagePath = ""

    func loadImageUsing(path: String) {

        imagePath = path
        guard let url = URL(string: path) else { return }

        self.image = UIImage(named: "movie-cover")

        if let imageFromCache = imageCache.object(forKey: path as NSString) {
            self.image = imageFromCache
            return
        }

        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) -> () in
            if error != nil { return }

            guard let data = data else  { return }

            DispatchQueue.main.async {
                guard let imageToCache = UIImage(data: data) else { return }
                if self.imagePath == path {
                    self.image = imageToCache
                }
                imageCache.setObject(imageToCache, forKey: path as NSString)
            }
        }).resume()
    }
}
