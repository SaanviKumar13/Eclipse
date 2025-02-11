//
//  CustomBookTableViewCell.swift
//  Eclipse
//
//  Created by user@87 on 05/11/24.
//
import UIKit

protocol CustomBookTableViewCellDelegate: AnyObject {
    func didSelectBookmark(for book: Book)
}

class CustomBookTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var bookmarkButton: UIButton!

    weak var delegate: CustomBookTableViewCellDelegate?
   
    var book: Book? {
        didSet {
            updateUI()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
        setupBookmarkButton()
    }

    private func setupUI() {
        descriptionLabel.numberOfLines = 3
        descriptionLabel.lineBreakMode = .byTruncatingTail
        
        bookImage.layer.cornerRadius = 10
        bookImage.layer.masksToBounds = true
        bookImage.layer.borderWidth = 1.0
        bookImage.layer.borderColor = UIColor.lightGray.cgColor

        self.layer.cornerRadius = 10
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = 4
        
        styleLabels()
    }

    private func styleLabels() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = UIColor.black
        authorLabel.font = UIFont.systemFont(ofSize: 14)
        authorLabel.textColor = UIColor.gray
    }

    private func setupBookmarkButton() {
        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
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
