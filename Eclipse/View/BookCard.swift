//
//  BookCell.swift
//  Eclipse

import UIKit

// First, let's create a proper model for the book
struct BookData {
    let title: String
    let borrowedFrom: String? // for borrowed books
    let lentTo: String? // for lent books
    let price: String
    let days: String
    let coverImage: UIImage
}

class BookCard: UITableViewCell {
    
    private let coverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.backgroundColor = .systemGray5
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    

    private let titleLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 16, weight: .semibold)
            label.numberOfLines = 2
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private let borrowerLenderLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.textColor = .systemGray
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private let priceLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            label.textAlignment = .center
            label.backgroundColor = UIColor.systemGray5 // Light grey background
            label.layer.cornerRadius = 5
            label.clipsToBounds = true
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private let daysLabel: UILabel = {
            let label = UILabel()
            label.font = .systemFont(ofSize: 14)
            
            label.textAlignment = .center
            label.backgroundColor = UIColor(hex: "#005C78") // Light grey background
            
            label.textColor = .white
            label.layer.cornerRadius = 5
            label.clipsToBounds = true
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        private let chatButton: UIButton = {
            let button = UIButton(type: .system)
            button.setImage(UIImage(systemName: "bubble.right"), for: .normal)
            button.tintColor = UIColor(named: "#005C78") ?? .systemBlue
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        private let returnButton: UIButton = {
            let button = UIButton(type: .system)
            button.setTitle("Return", for: .normal)
            button.setTitleColor(UIColor(named: "#005C78") ?? .systemBlue, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
    private let separatorLine: UIView = {
            let line = UIView()
            line.backgroundColor = .systemGray5
            line.translatesAutoresizingMaskIntoConstraints = false
            return line
        }()


        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setupCell()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        private func setupCell() {
            contentView.addSubview(coverImageView)
            contentView.addSubview(titleLabel)
            contentView.addSubview(borrowerLenderLabel)
            contentView.addSubview(priceLabel)
            contentView.addSubview(daysLabel)
            contentView.addSubview(chatButton)
            contentView.addSubview(returnButton)
            contentView.addSubview(separatorLine)
            
            NSLayoutConstraint.activate([
                // Cover image
                coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                coverImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                coverImageView.widthAnchor.constraint(equalToConstant: 60),
                coverImageView.heightAnchor.constraint(equalToConstant: 90),
                
                // Title
                titleLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 12),
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                titleLabel.trailingAnchor.constraint(equalTo: chatButton.leadingAnchor, constant: -8),
                
                // Borrower/Lender label
                borrowerLenderLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 12),
                borrowerLenderLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
                
                // Price label
                priceLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 12),
                priceLabel.topAnchor.constraint(equalTo: borrowerLenderLabel.bottomAnchor, constant: 8),
                priceLabel.widthAnchor.constraint(equalToConstant: 50),
                priceLabel.heightAnchor.constraint(equalToConstant: 25),
                
                // Days label
                daysLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 8),
                daysLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
                daysLabel.widthAnchor.constraint(equalToConstant: 70),
                daysLabel.heightAnchor.constraint(equalToConstant: 25),
                
                // Chat button
                chatButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                chatButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                chatButton.widthAnchor.constraint(equalToConstant: 30),
                chatButton.heightAnchor.constraint(equalToConstant: 30),
                
                // Return button
                returnButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                returnButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
                
                separatorLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                            separatorLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                            separatorLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                            separatorLine.heightAnchor.constraint(equalToConstant: 1)
            ])
        }
        
        func configure(with book: BookData, isLentBook: Bool = false) {
            titleLabel.text = book.title
            if isLentBook {
                borrowerLenderLabel.text = "Lent to \(book.lentTo ?? "")"
            } else {
                borrowerLenderLabel.text = "Borrowed from \(book.borrowedFrom ?? "")"
            }
            priceLabel.text = book.price
            daysLabel.text = book.days
            coverImageView.image = book.coverImage
            
            // Set minimum height for the cell
            let minHeight: CGFloat = 120
            if frame.height < minHeight {
                frame.size.height = minHeight
            }
        }

    }