//
//  GuidedListCollectionViewCell.swift
//  Eclipse
//
//  Created by user@87 on 18/11/24.
//

import UIKit

class GuidedListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var bookImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bookImage.layer.cornerRadius = 10
        bookImage.clipsToBounds = true
    }
}
