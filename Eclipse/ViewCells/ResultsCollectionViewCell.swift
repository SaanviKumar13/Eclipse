//
//  ResultsCollectionViewCell.swift
//  Eclipse
//
//  Created by user@87 on 15/11/24.
//
import UIKit

class ResultsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var desc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        title.textColor = UIColor.darkText
        title.numberOfLines = 0
        
        desc.textColor = UIColor.darkGray
        desc.numberOfLines = 0
        
        bookImage.layer.cornerRadius = 10
        bookImage.layer.masksToBounds = true
        bookImage.layer.borderWidth = 1.0
        bookImage.layer.borderColor = UIColor.lightGray.cgColor
        bookImage.layer.shadowColor = UIColor.black.cgColor
        bookImage.layer.shadowOpacity = 0.1
        bookImage.layer.shadowOffset = CGSize(width: 0, height: 2)
        bookImage.layer.shadowRadius = 4
    }
    
    func configureCell(book: Book) {
        bookImage.image = book.coverImageURL
        title.text = book.title
        desc.text = book.description
    }
}

