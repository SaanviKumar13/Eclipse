//
//  customerMessageCell.swift
//  Eclipse
//
//  Created by admin48 on 19/11/24.
//


import UIKit
class customerMessageCell: UITableViewCell {
    
    // MARK: - UI Elements
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let messageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let bubbleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Constraints
    private var bubbleLeadingConstraint: NSLayoutConstraint!
    private var bubbleTrailingConstraint: NSLayoutConstraint!
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        contentView.backgroundColor = .clear
        
        // Add Bubble View
        contentView.addSubview(bubbleView)
        
        // Add Message Label
        bubbleView.addSubview(messageLabel)
        
        // Add Message Image View
        bubbleView.addSubview(messageImageView)
        
        // Define Bubble Constraints
        bubbleLeadingConstraint = bubbleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        bubbleTrailingConstraint = bubbleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        
        // Activate Constraints
        NSLayoutConstraint.activate([
            // Bubble View
            bubbleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            bubbleView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            bubbleView.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            // Message Label
            messageLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 6),
            messageLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -6),
            messageLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 10),
            messageLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -10),
            
            // Message Image View
            messageImageView.topAnchor.constraint(equalTo: bubbleView.topAnchor),
            messageImageView.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor),
            messageImageView.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor),
            messageImageView.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor),
            messageImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 150)
        ])
    }
    
    // MARK: - Configuration
    func configure(with message: Message) {
        if message.isImage ?? false, let imageName = message.imageName {
            // Display Image
            messageLabel.isHidden = true
            messageImageView.isHidden = false
            messageImageView.image = UIImage(named: imageName)
            bubbleView.backgroundColor = .clear // No background color for images
        } else {
            // Display Text
            messageLabel.isHidden = false
            messageImageView.isHidden = true
            messageLabel.text = message.text
            bubbleView.backgroundColor = message.isFromUser ? UIColor(hex: "#005C78") : .systemGray5
            messageLabel.textColor = message.isFromUser ? .white : .black
        }
        
        // Update Bubble Alignment
        if message.isFromUser {
            bubbleTrailingConstraint.isActive = true
            bubbleLeadingConstraint.isActive = false
        } else {
            bubbleTrailingConstraint.isActive = false
            bubbleLeadingConstraint.isActive = true
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        messageLabel.text = nil
        messageImageView.image = nil
    }
}

