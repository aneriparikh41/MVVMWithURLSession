//
//  ImageDownloader.swift
//  MVVMDemo
//
//  Created by Aneri Parikh on 23/04/22.
//

import UIKit
import Foundation

protocol ImageDownloaderProtocol {
    func download(urlString: String, completion: @escaping (UIImage?, String) -> ())
}

// Use cache later
class ImageDownloader: ImageDownloaderProtocol {
    static let shared = ImageDownloader()
    fileprivate init() {}

    var currentReq = [String]()
    var imageCache = NSCache<AnyObject, UIImage>()

    func download(urlString: String, completion: @escaping (UIImage?, String) -> ()) {
        if let image = imageCache.object(forKey: urlString as! AnyObject) {
            completion(image, urlString)
            return
        }

        guard let url = URL(string: urlString) else {
            completion(nil, urlString)
            return
        }
        if currentReq.contains(urlString) {return}
        currentReq.append(urlString)
        URLSession.shared.dataTask(with: url) {[weak self] data, _, error in
            self?.currentReq.remove(urlString)
            guard let data = data,
            let image = UIImage(data: data) else {
                completion(nil, urlString)
                return
            }
            self?.imageCache.setObject(image, forKey: urlString as! AnyObject)
            completion(image, urlString)
        }.resume()
    }
}

extension Array where Element: Equatable {
    mutating func remove(_ str: Element) {
        guard let index = self.firstIndex(of: str) else {return}
        remove(at:index)
    }

}

