//
//  CustomCell.swift
//  Eclipse
//
//  Created by admin48 on 17/11/24.
//

import UIKit



protocol NearbyRentersCellDelegate: AnyObject {
    func requestRentTapped(for cell: CustomCell)
}

class CustomCell: UITableViewCell {
    private let profileImageView = UIImageView()
    private let nameLabel = UILabel()
    private let locationIcon = UIImageView()
    private let distanceLabel = UILabel()
    private let priceLabel = UILabel()
    private let requestButton = UIButton()
    
    private let separatorLine: UIView = {
            let line = UIView()
            line.backgroundColor = .systemGray5
            line.translatesAutoresizingMaskIntoConstraints = false
            return line
        }()
    
    weak var delegate: NearbyRentersCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        selectionStyle = .none
        
        // Profile Image
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.layer.cornerRadius = 25
        profileImageView.clipsToBounds = true
        profileImageView.contentMode = .scaleAspectFill
        
        // Name Label
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = .systemFont(ofSize: 17, weight: .medium)
        
        // Location Icon
        locationIcon.image = UIImage(systemName: "location.fill")
        locationIcon.tintColor = .systemGray
        locationIcon.translatesAutoresizingMaskIntoConstraints = false
        locationIcon.contentMode = .scaleAspectFit
        
        // Distance Label
        distanceLabel.translatesAutoresizingMaskIntoConstraints = false
        distanceLabel.font = .systemFont(ofSize: 15)
        distanceLabel.textColor = .systemGray
        
        // Price Label
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceLabel.font = .systemFont(ofSize: 17, weight: .medium)
        priceLabel.textColor =  UIColor(hex: "A40000")
       
        
        // Request Button
        requestButton.setTitle("Request Rent", for: .normal)
        requestButton.setTitleColor(UIColor(hex: "005C78"), for: .normal)
        
        requestButton.titleLabel?.font = .systemFont(ofSize: 17)
        requestButton.translatesAutoresizingMaskIntoConstraints = false
        requestButton.addTarget(self, action: #selector(requestRentTapped), for: .touchUpInside)
        
        // Add subviews
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(locationIcon)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(requestButton)
        contentView.addSubview(separatorLine)
        
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 50),
            profileImageView.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 15),
            nameLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 2),
            
            locationIcon.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            locationIcon.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            locationIcon.widthAnchor.constraint(equalToConstant: 15),
            locationIcon.heightAnchor.constraint(equalToConstant: 15),
            
            distanceLabel.leadingAnchor.constraint(equalTo: locationIcon.trailingAnchor, constant: 5),
            distanceLabel.centerYAnchor.constraint(equalTo: locationIcon.centerYAnchor),
            
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            priceLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            
            requestButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            requestButton.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor),
            
            separatorLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                        separatorLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                        separatorLine.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                        separatorLine.heightAnchor.constraint(equalToConstant: 1)
        ])
      
    }
    
    @objc private func requestRentTapped() {
        delegate?.requestRentTapped(for: self)
    }
    
    func configure(name: String, distance: Double, price: Double, profileImage: UIImage) {
        profileImageView.image = profileImage
        nameLabel.text = name
        distanceLabel.text = "\(distance)Km"
        priceLabel.text = "₹\(Int(price)) per day"
    }
}
