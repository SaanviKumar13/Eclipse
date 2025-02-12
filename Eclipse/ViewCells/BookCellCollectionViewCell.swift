//
//  BookCoverCell.swift
//  Eclipse
//
//  Created by admin48 on 15/11/24.
//
//
//import UIKit
//import SDWebImage
//
//
//
//class BookCell: UICollectionViewCell {
//    private let imageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
//        imageView.layer.cornerRadius = 8
//        return imageView
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupUI() {
//        contentView.addSubview(imageView)
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
//    }
//    
////    private func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
////        let task = URLSession.shared.dataTask(with: url) { data, _, error in
////            if let data = data, let image = UIImage(data: data) {
////                completion(image)
////            } else {
////                completion(nil) // Return nil if the image download fails
////            }
////        }
////        task.resume()
////    }
//    
//    
//    //    func configure(with book: BookF) {
//    //        imageView.image = UIImage(systemName: "book.fill") // Placeholder image
//    //
//    //        if let imageURL = book.imageLinks?.thumbnail, let url = URL(string: imageURL) {
//    //            downloadImage(from: url) { [weak self] image in
//    //                DispatchQueue.main.async {
//    //                    self?.imageView.image = image
//    //                }
//    func configure(with book: BookF) {
//        imageView.image = UIImage(systemName: "book.fill") // Placeholder image
//        
//        guard let imageURL = book.imageLinks?.thumbnail else {
//            print("❌ No image URL found for book: \(book.title)")
//            return
//        }
//        
//        let secureURL = imageURL.replacingOccurrences(of: "http://", with: "https://")
//        print("🔗 Final Image URL: \(secureURL)")
//
//        guard let url = URL(string: secureURL) else {
//            print("❌ Invalid URL: \(secureURL)")
//            return
//        }
//        
//        imageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "book.fill"))
//
//    }
//
////    private func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
////        let task = URLSession.shared.dataTask(with: url) { data, _, error in
////            if let error = error {
////                print("❌ Image download error: \(error.localizedDescription)")
////                completion(nil)
////                return
////            }
////
////            guard let data = data, let image = UIImage(data: data) else {
////                print("❌ Image data is invalid")
////                completion(nil)
////                return
////            }
////
////            print("✅ Image downloaded successfully!")
////            completion(image)
////        }
////        task.resume()
////    }
//
//
//}
import UIKit
import SDWebImage

class BookCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with book: BookF) {
        imageView.image = UIImage(systemName: "book.fill") // Placeholder image
        
        guard let imageURL = book.imageLinks?.thumbnail else {
            print("❌ No image URL found for book: \(book.title)")
            return
        }
        
        let secureURL = imageURL.replacingOccurrences(of: "http://", with: "https://")
        print("🔗 Final Image URL: \(secureURL)")
        
        guard let url = URL(string: secureURL) else {
            print("❌ Invalid URL: \(secureURL)")
            return
        }
        
        imageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "book.fill"))
    }
}
