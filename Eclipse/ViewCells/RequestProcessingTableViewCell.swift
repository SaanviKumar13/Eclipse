//
//  RequestsProcessingTableViewCell.swift
//  Eclipse
//
//  Created by admin48 on 12/11/24.
//


import UIKit

class RequestssTableViewCell: UITableViewCell {

    // UI Components
    private let bookCoverImageView = UIImageView()
    let profileButton = UIButton() // Changed from UIImageView to UIButton
    private let titleLabel = UILabel()
    private let renterLabel = UILabel()
    private let priceLabel = UILabel()
    private let daysLabel = UILabel()

    private let acceptedButton = UIButton()
    private let underReviewButton = UIButton()
    private let rejectedButton = UIButton()

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

        // Setup for profile button (replacing profile image)
        profileButton.imageView?.contentMode = .scaleAspectFill
        profileButton.layer.cornerRadius = 20
        profileButton.clipsToBounds = true
        profileButton.translatesAutoresizingMaskIntoConstraints = false

        // Setup for title label
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
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

        // Setup for status buttons
        setupStatusButton(acceptedButton, title: "Accepted", backgroundColor: .systemGreen)
        setupStatusButton(underReviewButton, title: " Reviewing", backgroundColor: .systemGray)
        setupStatusButton(rejectedButton, title: "Rejected", backgroundColor: .systemRed)

        // Add subviews
        contentView.addSubview(bookCoverImageView)
        contentView.addSubview(profileButton) // Add the profile button instead of image
        contentView.addSubview(titleLabel)
        contentView.addSubview(renterLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(daysLabel)
        contentView.addSubview(acceptedButton)
        contentView.addSubview(underReviewButton)
        contentView.addSubview(rejectedButton)

        // Constraints setup
        NSLayoutConstraint.activate([
            // Book cover
            bookCoverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            bookCoverImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            bookCoverImageView.widthAnchor.constraint(equalToConstant: 60),
            bookCoverImageView.heightAnchor.constraint(equalToConstant: 90),

            // Profile button
            profileButton.leadingAnchor.constraint(equalTo: bookCoverImageView.trailingAnchor, constant: 10),
            profileButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            profileButton.widthAnchor.constraint(equalToConstant: 40),
            profileButton.heightAnchor.constraint(equalToConstant: 40),

            // Title label
            titleLabel.leadingAnchor.constraint(equalTo: profileButton.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: acceptedButton.leadingAnchor, constant: -10),

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

            // Accepted button
            acceptedButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            acceptedButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            acceptedButton.widthAnchor.constraint(equalToConstant: 90),
            acceptedButton.heightAnchor.constraint(equalToConstant: 30),

            // Under Review button
            underReviewButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            underReviewButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            underReviewButton.widthAnchor.constraint(equalToConstant: 90),
            underReviewButton.heightAnchor.constraint(equalToConstant: 30),

            // Rejected button
            rejectedButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            rejectedButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            rejectedButton.widthAnchor.constraint(equalToConstant: 90),
            rejectedButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }

    private func setupStatusButton(_ button: UIButton, title: String, backgroundColor: UIColor) {
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
    }

    func configure(with request: RentalRequestsProcessingViewController.BookRequests, status: String) {
        bookCoverImageView.image = request.bookCover
        profileButton.setImage(request.profileImage, for: .normal)
        titleLabel.text = request.title
        renterLabel.text = request.renter
        priceLabel.text = request.price
        daysLabel.text = request.days

        // Hide all status buttons initially
        acceptedButton.isHidden = true
        underReviewButton.isHidden = true
        rejectedButton.isHidden = true

        // Show the correct status button based on the status parameter
        switch status {
        case "Accepted":
            acceptedButton.isHidden = false
        case "Under Review":
            underReviewButton.isHidden = false
        case "Rejected":
            rejectedButton.isHidden = false
        default:
            break
        }
    }
}


