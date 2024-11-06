//
//  CategoryCollectionViewCell.swift
//  Eclipse
//
//  Created by user@87 on 30/10/24.
//

import UIKit


class CategoryCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
    
    func configure(for category: String, isSelected: Bool) {
        categoryLabel.text = category
        
        let selectedColor = UIColor(red: 0.0, green: 92/255.0, blue: 120/255.0, alpha: 1.0)
        let unselectedColor = UIColor.white
        
        if isSelected {
            self.backgroundColor = selectedColor
            categoryLabel.textColor = UIColor.white
        } else {
            self.backgroundColor = unselectedColor
            categoryLabel.textColor = selectedColor
        }
    }

    
    override func awakeFromNib() {
           super.awakeFromNib()
           
           self.layer.cornerRadius = 10
           self.layer.masksToBounds = false
           self.layer.shadowColor = UIColor.black.cgColor
           self.layer.shadowOpacity = 0.2
           self.layer.shadowOffset = CGSize(width: 2, height: 2)
           self.layer.shadowRadius = 4
       }
}
