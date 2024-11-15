//
//  RequestsProcessingTableViewCell.swift
//  Eclipse
//
//  Created by admin48 on 12/11/24.
//

//import UIKit
//
//class RequestsProcessingTableViewCell: UITableViewCell {
//    
//    private let coverImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFill
//        imageView.layer.cornerRadius = 8
//        imageView.clipsToBounds = true
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        return imageView
//    }()
//    
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 16, weight: .semibold)
//        label.numberOfLines = 2
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let userNameLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 14)
//        label.textColor = .darkGray
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let priceLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 14)
//        label.textAlignment = .center
//        label.backgroundColor = UIColor.systemGray6
//        label.layer.cornerRadius = 5
//        label.clipsToBounds = true
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let daysLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 14)
//        label.textAlignment = .center
//        label.backgroundColor = UIColor(hex: "#005C78")
//        label.textColor = .white
//        label.layer.cornerRadius = 5
//        label.clipsToBounds = true
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//    
//    private let statusButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
//        button.setTitleColor(.white, for: .normal)
//        button.layer.cornerRadius = 5
//        button.clipsToBounds = true
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    // Method to configure cell data
//    func configure(with book: BookData, status: String) {
//        coverImageView.image = book.coverImage
//        titleLabel.text = book.title
//        userNameLabel.text = book.lentTo ?? book.borrowedFrom ?? ""
//        priceLabel.text = book.price
//        daysLabel.text = book.days
//        
//        switch status {
//        case "Rejected":
//            statusButton.setTitle("Rejected", for: .normal)
//            statusButton.backgroundColor = .systemRed
//        case "Under Review":
//            statusButton.setTitle("Under Review", for: .normal)
//            statusButton.backgroundColor = .systemGray
//        case "Pay":
//            statusButton.setTitle("Pay", for: .normal)
//            statusButton.backgroundColor = .systemGreen
//            statusButton.setTitleColor(.systemGreen, for: .normal)
//        case "Accepted":
//            statusButton.setTitle("Accepted", for: .normal)
//            statusButton.backgroundColor = .systemGreen
//        default:
//            statusButton.setTitle("", for: .normal)
//        }
//    }
//    
//    // Add subviews and constraints
//    private func setupViews() {
//        contentView.addSubview(coverImageView)
//        contentView.addSubview(titleLabel)
//        contentView.addSubview(userNameLabel)
//        contentView.addSubview(priceLabel)
//        contentView.addSubview(daysLabel)
//        contentView.addSubview(statusButton)
//        
//        NSLayoutConstraint.activate([
//            coverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            coverImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            coverImageView.widthAnchor.constraint(equalToConstant: 60),
//            coverImageView.heightAnchor.constraint(equalToConstant: 90),
//            
//            titleLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 12),
//            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
//            
//            userNameLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 12),
//            userNameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
//            
//            priceLabel.leadingAnchor.constraint(equalTo: coverImageView.trailingAnchor, constant: 12),
//            priceLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
//            priceLabel.widthAnchor.constraint(equalToConstant: 50),
//            priceLabel.heightAnchor.constraint(equalToConstant: 25),
//            
//            daysLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 8),
//            daysLabel.centerYAnchor.constraint(equalTo: priceLabel.centerYAnchor),
//            daysLabel.widthAnchor.constraint(equalToConstant: 70),
//            daysLabel.heightAnchor.constraint(equalToConstant: 25),
//            
//            statusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            statusButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            statusButton.widthAnchor.constraint(equalToConstant: 80),
//            statusButton.heightAnchor.constraint(equalToConstant: 30)
//        ])
//    }
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupViews()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}



//import UIKit
//
//class RequestsProcessingTableViewCell: UITableViewCell {
//    
//    // UI Components
//    private let bookCoverImageView = UIImageView()
//    private let profileImageView = UIImageView()
//    private let titleLabel = UILabel()
//    private let renterLabel = UILabel()
//    private let priceLabel = UILabel()
//    private let daysLabel = UILabel()
//    
//    private let acceptedButton = UIButton()
//    private let underReviewButton = UIButton()
//    private let rejectedButton = UIButton()
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupViews()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupViews() {
//        // Setup for book cover image
//        bookCoverImageView.contentMode = .scaleAspectFill
//        bookCoverImageView.layer.cornerRadius = 8
//        bookCoverImageView.clipsToBounds = true
//        bookCoverImageView.translatesAutoresizingMaskIntoConstraints = false
//        
//        // Setup for profile image
//        profileImageView.contentMode = .scaleAspectFill
//        profileImageView.layer.cornerRadius = 20
//        profileImageView.clipsToBounds = true
//        profileImageView.translatesAutoresizingMaskIntoConstraints = false
//        
//        // Setup for title label
//        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
//        titleLabel.numberOfLines = 2
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        // Setup for renter label
//        renterLabel.font = UIFont.systemFont(ofSize: 14)
//        renterLabel.textColor = .darkGray
//        renterLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        // Setup for price label
//        priceLabel.font = UIFont.systemFont(ofSize: 14)
//        priceLabel.textColor = .black
//        priceLabel.backgroundColor = UIColor(hex: "#ECECEC")
//        priceLabel.layer.cornerRadius = 5
//        priceLabel.clipsToBounds = true
//        priceLabel.textAlignment = .center
//        priceLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        // Setup for days label
//        daysLabel.font = UIFont.systemFont(ofSize: 14)
//        daysLabel.textColor = .white
//        daysLabel.backgroundColor = UIColor(hex: "#005C78")
//        daysLabel.layer.cornerRadius = 5
//        daysLabel.clipsToBounds = true
//        daysLabel.textAlignment = .center
//        daysLabel.translatesAutoresizingMaskIntoConstraints = false
//        
//        // Setup for status buttons
//        setupStatusButton(acceptedButton, title: "Accepted", backgroundColor: .systemGreen)
//        setupStatusButton(underReviewButton, title: "Under Review", backgroundColor: .systemGray)
//        setupStatusButton(rejectedButton, title: "Rejected", backgroundColor: .systemRed)
//        
//        // Add subviews
//        contentView.addSubview(bookCoverImageView)
//        contentView.addSubview(profileImageView)
//        contentView.addSubview(titleLabel)
//        contentView.addSubview(renterLabel)
//        contentView.addSubview(priceLabel)
//        contentView.addSubview(daysLabel)
//        contentView.addSubview(acceptedButton)
//        contentView.addSubview(underReviewButton)
//        contentView.addSubview(rejectedButton)
//        
//        // Constraints setup
//        NSLayoutConstraint.activate([
//            // Book cover
//            bookCoverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
//            bookCoverImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            bookCoverImageView.widthAnchor.constraint(equalToConstant: 60),
//            bookCoverImageView.heightAnchor.constraint(equalToConstant: 90),
//            
//            // Profile image
//            profileImageView.leadingAnchor.constraint(equalTo: bookCoverImageView.trailingAnchor, constant: 10),
//            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            profileImageView.widthAnchor.constraint(equalToConstant: 40),
//            profileImageView.heightAnchor.constraint(equalToConstant: 40),
//            
//            // Title label
//            titleLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
//            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: acceptedButton.leadingAnchor, constant: -10),
//            
//            // Renter label
//            renterLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
//            renterLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
//            
//            // Price label
//            priceLabel.leadingAnchor.constraint(equalTo: bookCoverImageView.trailingAnchor, constant: 10),
//            priceLabel.topAnchor.constraint(equalTo: renterLabel.bottomAnchor, constant: 5),
//            priceLabel.widthAnchor.constraint(equalToConstant: 50),
//            priceLabel.heightAnchor.constraint(equalToConstant: 25),
//            
//            // Days label
//            daysLabel.leadingAnchor.constraint(equalTo: priceLabel.trailingAnchor, constant: 10),
//            daysLabel.topAnchor.constraint(equalTo: renterLabel.bottomAnchor, constant: 5),
//            daysLabel.widthAnchor.constraint(equalToConstant: 70),
//            daysLabel.heightAnchor.constraint(equalToConstant: 25),
//            
//            // Accepted button
//            acceptedButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
//            acceptedButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            acceptedButton.widthAnchor.constraint(equalToConstant: 90),
//            acceptedButton.heightAnchor.constraint(equalToConstant: 30),
//            
//            // Under Review button
//            underReviewButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
//            underReviewButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            underReviewButton.widthAnchor.constraint(equalToConstant: 90),
//            underReviewButton.heightAnchor.constraint(equalToConstant: 30),
//            
//            // Rejected button
//            rejectedButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
//            rejectedButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
//            rejectedButton.widthAnchor.constraint(equalToConstant: 90),
//            rejectedButton.heightAnchor.constraint(equalToConstant: 30),
//        ])
//    }
//    
//    private func setupStatusButton(_ button: UIButton, title: String, backgroundColor: UIColor) {
//        button.setTitle(title, for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
//        button.setTitleColor(.white, for: .normal)
//        button.backgroundColor = backgroundColor
//        button.layer.cornerRadius = 5
//        button.clipsToBounds = true
//        button.translatesAutoresizingMaskIntoConstraints = false
//    }
//    
//    func configure(with request: RentalRequestsAcceptViewController.BookRequest, status: String) {
//        bookCoverImageView.image = request.bookCover
//        profileImageView.image = request.profileImage
//        titleLabel.text = request.title
//        renterLabel.text = request.renter
//        priceLabel.text = request.price
//        daysLabel.text = request.days
//        
//        // Hide all status buttons initially
//        acceptedButton.isHidden = true
//        underReviewButton.isHidden = true
//        rejectedButton.isHidden = true
//        
//        // Show the correct status button based on the status parameter
//        
//        switch status {
//        case "Accepted":
//            acceptedButton.isHidden = false
//        case "Under Review":
//            underReviewButton.isHidden = false
//        case "Rejected":
//            rejectedButton.isHidden = false
//        default:
//            break
//        }
//    }
//}

//import UIKit
//
//class RequestssTableViewCell: UITableViewCell {
//    
//    // UI Components
//    private let bookCoverImageView = UIImageView()
//    private let profileImageView = UIImageView()
//    private let titleLabel = UILabel()
//    private let renterLabel = UILabel()
//    private let priceLabel = UILabel()
//    private let daysLabel = UILabel()
//    private let statusLabel = UILabel()  // New label for status
//    
//    // Initialize components
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupViews()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupViews() {
//        // Book cover image
//        bookCoverImageView.contentMode = .scaleAspectFill
//        bookCoverImageView.layer.cornerRadius = 8
//        bookCoverImageView.clipsToBounds = true
//        bookCoverImageView.translatesAutoresizingMaskIntoConstraints = false
//
//        // Profile image
//        profileImageView.contentMode = .scaleAspectFill
//        profileImageView.layer.cornerRadius = 20
//        profileImageView.clipsToBounds = true
//        profileImageView.translatesAutoresizingMaskIntoConstraints = false
//
//        // Title label
//        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
//        titleLabel.numberOfLines = 2
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        // Renter label
//        renterLabel.font = UIFont.systemFont(ofSize: 14)
//        renterLabel.textColor = .darkGray
//        renterLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        // Price label
//        priceLabel.font = UIFont.systemFont(ofSize: 14)
//        priceLabel.textColor = .black
//        priceLabel.backgroundColor = UIColor(hex: "#ECECEC")
//        priceLabel.layer.cornerRadius = 5
//        priceLabel.clipsToBounds = true
//        priceLabel.textAlignment = .center
//        priceLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        // Days label
//        daysLabel.font = UIFont.systemFont(ofSize: 14)
//        daysLabel.textColor = .white
//        daysLabel.backgroundColor = UIColor(hex: "#005C78")
//        daysLabel.layer.cornerRadius = 5
//        daysLabel.clipsToBounds = true
//        daysLabel.textAlignment = .center
//        daysLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        // Status label
//        statusLabel.font = UIFont.systemFont(ofSize: 14)
//        statusLabel.textAlignment = .center
//        statusLabel.layer.cornerRadius = 5
//        statusLabel.clipsToBounds = true
//        statusLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        // Add subviews
//        contentView.addSubview(bookCoverImageView)
//        contentView.addSubview(profileImageView)
//        contentView.addSubview(titleLabel)
//        contentView.addSubview(renterLabel)
//        contentView.addSubview(priceLabel)
//        contentView.addSubview(daysLabel)
//        contentView.addSubview(statusLabel)
//
//        // Set up constraints (for brevity, showing constraints only for a few components; ensure all are properly laid out in your code)
//        NSLayoutConstraint.activate([
//            bookCoverImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
//            bookCoverImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            bookCoverImageView.widthAnchor.constraint(equalToConstant: 60),
//            bookCoverImageView.heightAnchor.constraint(equalToConstant: 90),
//            
//            profileImageView.leadingAnchor.constraint(equalTo: bookCoverImageView.trailingAnchor, constant: 10),
//            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            profileImageView.widthAnchor.constraint(equalToConstant: 40),
//            profileImageView.heightAnchor.constraint(equalToConstant: 40),
//            
//            titleLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
//            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
//            
//            // Additional constraints for other components...
//        ])
//    }
//
//    // New configure method accepting BookData
//    func configure(with data: RentalRequestsProcessingViewController.BookData) {
//        bookCoverImageView.image = data.bookCover
//        profileImageView.image = data.profileImage
//        titleLabel.text = data.title
//        renterLabel.text = data.renter
//        priceLabel.text = data.price
//        daysLabel.text = data.days
//        
//        // Configure the status label based on the status
//        statusLabel.text = data.status
//        switch data.status {
//        case "Accepted":
//            statusLabel.backgroundColor = .green
//        case "Under Review":
//            statusLabel.backgroundColor = .orange
//        case "Rejected":
//            statusLabel.backgroundColor = .red
//        default:
//            statusLabel.backgroundColor = .gray
//        }
//    }
//}
import UIKit

class RequestssTableViewCell: UITableViewCell {

    // UI Components
    private let bookCoverImageView = UIImageView()
    private let profileImageView = UIImageView()
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

        // Setup for profile image
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false

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

        // Setup for status buttons
        setupStatusButton(acceptedButton, title: "Accepted", backgroundColor: .systemGreen)
        setupStatusButton(underReviewButton, title: " Reviewing", backgroundColor: .systemGray)
        setupStatusButton(rejectedButton, title: "Rejected", backgroundColor: .systemRed)

        // Add subviews
        contentView.addSubview(bookCoverImageView)
        contentView.addSubview(profileImageView)
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

            // Profile image
            profileImageView.leadingAnchor.constraint(equalTo: bookCoverImageView.trailingAnchor, constant: 10),
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            profileImageView.widthAnchor.constraint(equalToConstant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 40),

            // Title label
            titleLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: acceptedButton.leadingAnchor, constant: -10),

            // Renter label
            renterLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 10),
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
        profileImageView.image = request.profileImage
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
