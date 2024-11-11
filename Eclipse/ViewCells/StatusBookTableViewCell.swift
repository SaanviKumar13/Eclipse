//
//  StatusBookTableViewCell.swift
//  Eclipse
//
//  Created by user@87 on 11/11/24.
//
import UIKit

protocol StatusBookTableViewCellDelegate: AnyObject {
    func didSelectKebabMenu(for book: Book)
}

class StatusBookTableViewCell: UITableViewCell {

    let descriptionLabel = UILabel()
    let authorLabel = UILabel()
    let titleLabel = UILabel()
    let bookImage = UIImageView()
    let kebabMenuButton = UIButton(type: .system)

    weak var delegate: StatusBookTableViewCellDelegate?

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

        // Kebab Menu Button setup
        kebabMenuButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        kebabMenuButton.translatesAutoresizingMaskIntoConstraints = false
        kebabMenuButton.addTarget(self, action: #selector(kebabMenuButtonTapped), for: .touchUpInside)
        contentView.addSubview(kebabMenuButton)

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
            titleLabel.trailingAnchor.constraint(equalTo: kebabMenuButton.leadingAnchor, constant: -8),
            
            // Author Label Constraints
            authorLabel.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor, constant: 16),
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            // Description Label Constraints
            descriptionLabel.leadingAnchor.constraint(equalTo: bookImage.trailingAnchor, constant: 16),
            descriptionLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 4),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -16),

            // Kebab Menu Button Constraints
            kebabMenuButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            kebabMenuButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            kebabMenuButton.widthAnchor.constraint(equalToConstant: 24),
            kebabMenuButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }

    @objc private func kebabMenuButtonTapped() {
        guard let book = book else { return }
        delegate?.didSelectKebabMenu(for: book)
    }

    private func updateUI() {
        guard let book = book else { return }
        titleLabel.text = book.title
        authorLabel.text = book.author.name
        descriptionLabel.text = book.description
        bookImage.image = book.coverImageURL ?? UIImage(systemName: "book")
    }
}
