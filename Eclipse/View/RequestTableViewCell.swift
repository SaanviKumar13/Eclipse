//
//  RequestTableViewCell.swift
//  Eclipse
//
//  Created by admin48 on 09/11/24.
//
//
import UIKit

class RequestTableViewCell: UITableViewCell {
   
    
    // UI Components
    private let bookCoverImageView = UIImageView()
    var profileButton = UIButton()
    private let titleLabel = UILabel()
    private let renterLabel = UILabel()
    private let priceLabel = UILabel()
    private let daysLabel = UILabel()
    private let acceptButton = UIButton()
    private let declineButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        // Setup for book cover image
        bookCoverImageView.contentMode = .scaleAspectFill
        bookCoverImageView.layer.cornerRadius = 8
        bookCoverImageView.clipsToBounds = true
        bookCoverImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup for profile image
        profileButton.imageView?.contentMode = .scaleAspectFill
        profileButton.layer.cornerRadius = 20
        profileButton.clipsToBounds = true
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup for title label
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup for renter label
        renterLabel.font = UIFont.systemFont(ofSize: 14)
        renterLabel.textColor = .darkGray
        renterLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup for price label
        priceLabel.font = UIFont.systemFont(ofSize: 14)
        priceLabel.textColor = .black
        priceLabel.backgroundColor = UIColor(hex: "#ECECEC")
        priceLabel.layer.cornerRadius = 5
        priceLabel.clipsToBounds = true
        priceLabel.textAlignment = .center
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup for days label
        daysLabel.font = UIFont.systemFont(ofSize: 14)
        daysLabel.textColor = .white
        daysLabel.backgroundColor = UIColor(hex: "#005C78")
        daysLabel.layer.cornerRadius = 5
        daysLabel.clipsToBounds = true
        daysLabel.textAlignment = .center
        daysLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup for accept and decline buttons
        acceptButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        acceptButton.tintColor = .systemGreen
        acceptButton.translatesAutoresizingMaskIntoConstraints = false
        
        declineButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        declineButton.tintColor = .lightGray
        declineButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Add subviews
        contentView.addSubview(bookCoverImageView)
        contentView.addSubview(profileButton)
        contentView.addSubview(titleLabel)
        contentView.addSubview(renterLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(daysLabel)
        contentView.addSubview(acceptButton)
        contentView.addSubview(declineButton)
        
        // Constraints setup
        NSLayoutConstraint.activate([
            // Book cover
            bookCoverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            bookCoverImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            bookCoverImageView.widthAnchor.constraint(equalToConstant: 60),
            bookCoverImageView.heightAnchor.constraint(equalToConstant: 90),
            
            // Profile image
            profileButton.leadingAnchor.constraint(equalTo: bookCoverImageView.trailingAnchor, constant: 10),
            profileButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            profileButton.widthAnchor.constraint(equalToConstant: 40),
            profileButton.heightAnchor.constraint(equalToConstant: 40),
            
            // Title label
            titleLabel.leadingAnchor.constraint(equalTo: profileButton.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: acceptButton.leadingAnchor, constant: -10),
            
            // Renter label
            renterLabel.leadingAnchor.constraint(equalTo: profileButton.trailingAnchor, constant: 10),
            renterLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            
            // Price label
            priceLabel.leadingAnchor.constraint(equalTo: bookCoverImageView.trailingAnchor, constant: 10),
            priceLabel.topAnchor.constraint(equalTo: renterLabel.bottomAnchor, constant: 5),
            priceLabel.widthAnchor.constraint(equalToConstant: 50),
            priceLabel.heightAnchor.constraint(equalToConstant: 25),
            
            // Days label
            daysLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 10),
            daysLabel.topAnchor.constraint(equalTo: renterLabel.bottomAnchor, constant: 5),
            daysLabel.widthAnchor.constraint(equalToConstant: 70),
            daysLabel.heightAnchor.constraint(equalToConstant: 25),
            
            // Accept button
            acceptButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            acceptButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            acceptButton.widthAnchor.constraint(equalToConstant: 30),
            acceptButton.heightAnchor.constraint(equalToConstant: 30),
            
            // Decline button
            declineButton.trailingAnchor.constraint(equalTo: acceptButton.leadingAnchor, constant: -10),
            declineButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            declineButton.widthAnchor.constraint(equalToConstant: 30),
            declineButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    func configure(with request: RentalRequestsAcceptViewController.BookRequest, status: String) {
        bookCoverImageView.image = request.bookCover
        profileButton.setImage(request.profileImage, for: .normal)
        titleLabel.text = request.title
        renterLabel.text = request.renter
        priceLabel.text = request.price
        daysLabel.text = request.days
    }
}

