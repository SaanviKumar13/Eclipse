//
//  BookCollectionViewCell.swift
//  Eclipse
//
//  Created by user@87 on 30/10/24.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var coverImageView: UIImageView!
    
    func configure(with book: Book) {
        coverImageView.image = book.coverImageURL
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

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
}



