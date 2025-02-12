//
//  ImageLoader.swift
//  Eclipse
//
//  Created by admin48 on 12/02/25.
//

import UIKit

class ImageLoader {
    static func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Image download error: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                print("❌ HTTP Error: \(httpResponse.statusCode) for URL: \(url.absoluteString)")
                completion(nil)
                return
            }

            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                print("❌ Failed to create image from data")
                completion(nil)
            }
        }
        task.resume()
    }
}

