//
//  BooksCell.swift
//  Eclipse
//
//  Created by admin48 on 18/11/24.
//

//import UIKit
//
//class BooksCell: UICollectionViewCell {
//    private let nameLabel = UILabel()
//    private let imageView: UIImageView = {
//        let iv = UIImageView()
//        iv.translatesAutoresizingMaskIntoConstraints = false
//        iv.contentMode = .scaleAspectFill
//        iv.clipsToBounds = true
//        iv.layer.cornerRadius = 8
//        return iv
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
//        NSLayoutConstraint.activate([
//            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
//        ])
//    }
//    
//    
//    func configure(with book: BookF) {
//        imageView.image = UIImage(systemName: "book.fill") // Placeholder image
//        
//        if let imageURL = book.imageLinks?.thumbnail, let url = URL(string: imageURL) {
//            downloadImage(from: url) { [weak self] image in
//                DispatchQueue.main.async {
//                    self?.imageView.image = image
//                }
//            }
//        }
//    }
//
//
//}
//
import UIKit
import SDWebImage

class BooksCell: UICollectionViewCell {
    private let nameLabel = UILabel()
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 8
        return iv
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
        print("🔗 Loading Image URL: \(secureURL)")

        guard let url = URL(string: secureURL) else {
            print("❌ Invalid URL: \(secureURL)")
            return
        }

        downloadImage(from: url) { [weak self] image in
            DispatchQueue.main.async {
                self?.imageView.image = image ?? UIImage(systemName: "book.fill") // Fallback image
            }
        }
    }





}

