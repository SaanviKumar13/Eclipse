//
//  CategoryCollectionViewCell.swift
//  Eclipse
//
//  Created by user@87 on 11/11/24.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    private var categoryLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpViews()
    }
    
    private func setUpViews() {
        categoryLabel = UILabel()
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.textAlignment = .center
        categoryLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        contentView.addSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            categoryLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            categoryLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
    }
    
    func configure(for category: String, isSelected: Bool) {
        categoryLabel.text = category
        
        let selectedColor = UIColor(hex: "#005C78")
        let unselectedColor = UIColor.white
        let selectedTextColor = UIColor.white
        let unselectedTextColor = selectedColor
        
        if isSelected {
            contentView.backgroundColor = selectedColor
            categoryLabel.textColor = selectedTextColor
            categoryLabel.backgroundColor = .clear
        } else {
            contentView.backgroundColor = unselectedColor
            categoryLabel.textColor = unselectedTextColor
        }
    }
}
