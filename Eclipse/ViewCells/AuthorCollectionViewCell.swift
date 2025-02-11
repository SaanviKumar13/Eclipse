//
//  AuthorCollectionViewCell.swift
//  Eclipse
//
//  Created by user@87 on 16/11/24.
//

import UIKit

class AuthorCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var authorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        authorImage.layer.cornerRadius = 10
        authorImage.clipsToBounds = true
        authorView.layer.cornerRadius = 10
        authorName.clipsToBounds = true
        
        authorView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        authorView.layer.shadowPath = UIBezierPath(roundedRect: authorView.bounds, cornerRadius: 10).cgPath
    }
    
    func configure(for author: Author){
        authorName.text = author.name
        authorImage.image = author.image
    }
}
