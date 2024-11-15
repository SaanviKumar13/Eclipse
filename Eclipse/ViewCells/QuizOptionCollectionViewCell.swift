//
//  QuizOptionCollectionViewCell.swift
//  Eclipse
//
//  Created by user@87 on 15/11/24.
//

import UIKit

class QuizOptionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var optionButton: UIButton!
    
    // Add a property to track selection state
    private var isOptionSelected: Bool = false {
        didSet {
            updateAppearance()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupButton()
    }
    
    private func setupButton() {
        optionButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        optionButton.titleLabel?.numberOfLines = 0
        optionButton.contentHorizontalAlignment = .center
        optionButton.layer.cornerRadius = 12
        optionButton.layer.borderWidth = 1.5
        optionButton.clipsToBounds = true
        optionButton.frame = contentView.bounds
        optionButton.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        optionButton.isUserInteractionEnabled = false
        updateAppearance()
    }
    
    func configure(option: String, isSelected: Bool) {
        optionButton.setTitle(option, for: .normal)
        isOptionSelected = isSelected
    }
    
    private func updateAppearance() {
        if isOptionSelected {
            optionButton.layer.backgroundColor = UIColor(hex: "005C78").cgColor
            optionButton.setTitleColor(.white, for: .normal)
        } else {
            optionButton.layer.backgroundColor = UIColor.white.cgColor
            optionButton.setTitleColor(UIColor(hex: "005C78"), for: .normal)
            optionButton.layer.borderColor = UIColor.systemGray3.cgColor
        }
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.1
        layer.masksToBounds = false
    }
}
