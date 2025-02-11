//
//  RecommendedBookCollectionViewCell.swift
//  Eclipse
//
//  Created by user@87 on 16/11/24.
//

import UIKit

class RecommendedBookCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bookImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bookImage.layer.cornerRadius = 20
        bookImage.clipsToBounds = true
    }
}
