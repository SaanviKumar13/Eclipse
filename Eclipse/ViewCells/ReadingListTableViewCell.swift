//
//  ReadingListTableViewCell.swift
//  Eclipse
//
//  Created by user@87 on 11/11/24.
//

import UIKit

class ReadingListTableViewCell: UITableViewCell {

    var titleLabel: UILabel!
    var subtitleLabel: UILabel!
    var privacyIndicator: UIImageView!
    var book1: UIImageView!
    var book2: UIImageView!
    var book3: UIImageView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpViews()
    }
    
    private func setUpViews() {
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        contentView.addSubview(titleLabel)
        
        subtitleLabel = UILabel()
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        subtitleLabel.textColor = UIColor.gray
        contentView.addSubview(subtitleLabel)
        
        privacyIndicator = UIImageView()
        privacyIndicator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(privacyIndicator)
        
        book1 = UIImageView()
        book1.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(book1)
        
        book2 = UIImageView()
        book2.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(book2)
        
        book3 = UIImageView()
        book3.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(book3)
        
        setUpConstraints()
    }
    
    private func setUpConstraints() {
        // Constraints for titleLabel
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Constraints for subtitleLabel
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            // Constraints for privacyIndicator
            privacyIndicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            privacyIndicator.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8),
            privacyIndicator.widthAnchor.constraint(equalToConstant: 24),
            privacyIndicator.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        // Book images constraints: Adjust widths to be flexible
        let bookImageWidth: CGFloat = 40
        let spacing: CGFloat = 8
        
        NSLayoutConstraint.activate([
            book1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            book1.topAnchor.constraint(equalTo: privacyIndicator.bottomAnchor, constant: 8),
            book1.widthAnchor.constraint(equalToConstant: bookImageWidth),
            book1.heightAnchor.constraint(equalToConstant: 60),
            
            book2.leadingAnchor.constraint(equalTo: book1.trailingAnchor, constant: spacing),
            book2.topAnchor.constraint(equalTo: privacyIndicator.bottomAnchor, constant: 8),
            book2.widthAnchor.constraint(equalToConstant: bookImageWidth),
            book2.heightAnchor.constraint(equalToConstant: 60),
            
            book3.leadingAnchor.constraint(equalTo: book2.trailingAnchor, constant: spacing),
            book3.topAnchor.constraint(equalTo: privacyIndicator.bottomAnchor, constant: 8),
            book3.widthAnchor.constraint(equalToConstant: bookImageWidth),
            book3.heightAnchor.constraint(equalToConstant: 60),
            
            // Ensure book3 is constrained to the trailing edge
            book3.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subtitleLabel.text = nil
        privacyIndicator.image = nil
        book1.image = nil
        book2.image = nil
        book3.image = nil
    }
    
    // Method to configure the cell
    func configure(withTitle title: String, subtitle: String, privacyImage: UIImage?, bookImages: [UIImage]) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        privacyIndicator.image = privacyImage
        if bookImages.indices.contains(0) { book1.image = bookImages[0] }
        if bookImages.indices.contains(1) { book2.image = bookImages[1] }
        if bookImages.indices.contains(2) { book3.image = bookImages[2] }
    }
}
