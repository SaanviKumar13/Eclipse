//
//  ReadingListTableViewCell.swift
//  Eclipse
//
//  Created by user@87 on 11/11/24.
//
import UIKit

class ReadingListTableViewCell: UITableViewCell {
    // UI Elements
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let privacyIndicator = UIImageView()
    private let mainImageView = UIImageView()
    private let smallImageView1 = UIImageView()
    private let smallImageView2 = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        // Configure mainImageView
        mainImageView.contentMode = .scaleAspectFill
        mainImageView.clipsToBounds = true
        mainImageView.layer.cornerRadius = 4

        // Configure smallImageView1 and smallImageView2
        smallImageView1.contentMode = .scaleAspectFill
        smallImageView1.clipsToBounds = true
        smallImageView1.layer.cornerRadius = 4

        smallImageView2.contentMode = .scaleAspectFill
        smallImageView2.clipsToBounds = true
        smallImageView2.layer.cornerRadius = 4

        // Stack the two smaller images vertically
        let verticalImageStack = UIStackView(arrangedSubviews: [smallImageView1, smallImageView2])
        verticalImageStack.axis = .vertical
        verticalImageStack.spacing = 4
        verticalImageStack.distribution = .fillEqually

        // Horizontal stack for main image and vertical stack of smaller images
        let horizontalImageStack = UIStackView(arrangedSubviews: [mainImageView, verticalImageStack])
        horizontalImageStack.axis = .horizontal
        horizontalImageStack.spacing = 4

        // Configure titleLabel
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 1

        // Configure subtitleLabel (number of books)
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        subtitleLabel.textColor = .gray
        subtitleLabel.numberOfLines = 1

        // Configure privacyIndicator
        privacyIndicator.contentMode = .scaleAspectFit
        privacyIndicator.tintColor = .gray
        privacyIndicator.image = UIImage(systemName: "network")

        // Create a vertical stack for title, subtitle, and privacy indicator
        let verticalInfoStack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel, privacyIndicator])
        verticalInfoStack.axis = .vertical
        verticalInfoStack.spacing = 4
        verticalInfoStack.alignment = .leading

        // Main stack containing image stack and info stack
        let mainStackView = UIStackView(arrangedSubviews: [horizontalImageStack, verticalInfoStack])
        mainStackView.axis = .horizontal
        mainStackView.spacing = 12
        mainStackView.alignment = .center

        contentView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            mainImageView.widthAnchor.constraint(equalToConstant: 70), // Fixed width for main image
            mainImageView.heightAnchor.constraint(equalToConstant: 100), // Fixed height for main image
            
            verticalImageStack.widthAnchor.constraint(equalToConstant: 50), // Width for smaller images
            verticalImageStack.heightAnchor.constraint(equalTo: mainImageView.heightAnchor) // Match height with main image
        ])
    }


    func setThumbnails(images: [UIImage]) {
        mainImageView.image = images.indices.contains(0) ? images[0] : UIImage(named: "grey_bg")
        smallImageView1.image = images.indices.contains(1) ? images[1] : UIImage(named: "grey_bg")
        smallImageView2.image = images.indices.contains(2) ? images[2] : UIImage(named: "grey_bg")
    }
}

