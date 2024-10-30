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
        
        // Apply rounded corners to the image view
        coverImageView.layer.cornerRadius = 10
        coverImageView.layer.masksToBounds = true
        
        // Apply shadow and border to the cell itself
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = false
        
        // Apply shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = 4
        
        // Add border
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor // You can change this color as needed
    }
}



