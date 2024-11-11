//
//  BookCollectionViewCell.swift
//  Eclipse
//
//  Created by user@87 on 11/11/24.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    
    private var coverImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpViews()
    }
    
    private func setUpViews() {
        coverImageView = UIImageView()
        coverImageView.translatesAutoresizingMaskIntoConstraints = false
        coverImageView.contentMode = .scaleAspectFill
        contentView.addSubview(coverImageView)
        
        NSLayoutConstraint.activate([
            coverImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            coverImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            coverImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        coverImageView.layer.cornerRadius = 10
        coverImageView.layer.masksToBounds = true
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = 4
        
        coverImageView.layer.borderWidth = 1.0
        coverImageView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func configure(with book: Book) {
        coverImageView.image = book.coverImageURL
    }
}
