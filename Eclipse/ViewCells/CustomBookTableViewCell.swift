//
//  CustomBookTableViewCell.swift
//  Eclipse
//
//  Created by user@87 on 11/11/24.
//
import UIKit

protocol CustomBookTableViewCellDelegate: AnyObject {
    func didSelectBookmark(for book: Book)
}

class CustomBookTableViewCell: UITableViewCell {

    let descriptionLabel = UILabel()
    let authorLabel = UILabel()
    let titleLabel = UILabel()
    let bookImage = UIImageView()
    let bookmarkButton = UIButton(type: .system)

    weak var delegate: CustomBookTableViewCellDelegate?
   
    var book: Book? {
        didSet {
            updateUI()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        // Book Image setup
        bookImage.translatesAutoresizingMaskIntoConstraints = false
        bookImage.layer.cornerRadius = 10
        bookImage.layer.masksToBounds = true
        bookImage.layer.borderWidth = 1.0
        bookImage.layer.borderColor = UIColor.lightGray.cgColor
        contentView.addSubview(bookImage)
        
        // Title Label setup
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = UIColor.black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        // Author Label setup
        authorLabel.font = UIFont.systemFont(ofSize: 14)
        authorLabel.textColor = UIColor.gray
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(authorLabel)
        
        // Description Label setup
        descriptionLabel.numberOfLines = 3
        descriptionLabel.lineBreakMode = .byTruncatingTail
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(descriptionLabel)

        // Bookmark Button setup
        bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        bookmarkButton.translatesAutoresizingMaskIntoConstraints = false
        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
        contentView.addSubview(bookmarkButton)

        // Cell shadow and corner setup
        layer.cornerRadius = 10
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 4

        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Book Image Constraints
            bookImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bookImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            bookImage.widthAnchor.constraint(equalToConstant: 60),
            bookImage.heightAnchor.constraint(equalToConstant: 90),

            // Title Label Constraints
            titleLabel.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: bookmarkButton.leadingAnchor, constant: -8),
            
            // Author Label Constraints
            authorLabel.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor, constant: 16),
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            // Description Label Constraints
            descriptionLabel.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor, constant: 16),
            descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 4),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),

            // Bookmark Button Constraints
            bookmarkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bookmarkButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 24),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    @objc private func bookmarkButtonTapped() {
        guard let book = book else { return }
        delegate?.didSelectBookmark(for: book)
    }

    private func updateUI() {
        guard let book = book else { return }
        titleLabel.text = book.title
        authorLabel.text = book.author.name
        descriptionLabel.text = book.description
        bookImage.image = book.coverImageURL ?? UIImage(systemName: "book")
    }
}
